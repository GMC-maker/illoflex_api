/**
 * Contiene la logica de negocio del recurso test.
 * Aqui se validan las reglas del cuestionario y se generan los datos
 * necesarios antes de persistirlos.
 */
const { v4: uuidv4 } = require("uuid");
const sequelize = require("../config/sequelize");
const respuestaModel = require("../models/respuestaModel");
const resultadoModel = require("../models/resultadoModel");
const testModel = require("../models/testModel");

const createServiceError = (message, statusCode) => {
	const error = new Error(message);
	error.statusCode = statusCode;
	return error;
};

const getOpenVocationalTestByUuid = async (uuid) => {
	const vocationalTest = await testModel.getTestByUuid(uuid);

	if (!vocationalTest) {
		throw createServiceError("Test no encontrado", 404);
	}

	if (vocationalTest.estado !== "EN_PROGRESO") {
		throw createServiceError("El test ya no admite cambios", 409);
	}

	return vocationalTest;
};

const getSortedDimensionScores = (rawScores, activeOptionCounts) => {
	const activeOptionsByCode = activeOptionCounts.reduce((acc, row) => {
		acc[row.codigo] = Number(row.total_opciones);
		return acc;
	}, {});

	const scoresByCode = resultadoModel.BASE_PROFILES.reduce((acc, profile) => {
		acc[profile.codigo] = {
			codigo: profile.codigo,
			nombre: profile.nombre,
			descripcion: profile.descripcion,
			puntuacion_bruta: 0,
			total_opciones_activas: activeOptionsByCode[profile.codigo] || 0,
			puntuacion_normalizada: 0,
		};
		return acc;
	}, {});

	for (const row of rawScores) {
		const code = row.codigo;
		const rawScore = Number(row.puntuacion);
		const totalOptions = scoresByCode[code].total_opciones_activas;

		scoresByCode[code].puntuacion_bruta = rawScore;
		scoresByCode[code].puntuacion_normalizada =
			totalOptions > 0 ? Number((rawScore / totalOptions).toFixed(4)) : 0;
	}

	// Normaliza para compensar dimensiones con diferente numero de opciones activas.
	return Object.values(scoresByCode).sort((left, right) => {
		if (right.puntuacion_normalizada !== left.puntuacion_normalizada) {
			return right.puntuacion_normalizada - left.puntuacion_normalizada;
		}

		if (right.puntuacion_bruta !== left.puntuacion_bruta) {
			return right.puntuacion_bruta - left.puntuacion_bruta;
		}

		return left.codigo.localeCompare(right.codigo);
	});
};

const buildStoredScoresPayload = (sortedScores) => {
	const rawScores = {};
	const normalizedScores = {};

	for (const score of sortedScores) {
		rawScores[score.codigo] = score.puntuacion_bruta;
		normalizedScores[score.codigo] = score.puntuacion_normalizada;
	}

	return {
		brutas: rawScores,
		normalizadas: normalizedScores,
		ranking: sortedScores.map((score, index) => ({
			posicion: index + 1,
			codigo: score.codigo,
			nombre: score.nombre,
			puntuacion_bruta: score.puntuacion_bruta,
			puntuacion_normalizada: score.puntuacion_normalizada,
		})),
	};
};

const validateCompletedTestResponses = async (idTest) => {
	const activeQuestions = await respuestaModel.getActiveQuestions();
	const responseCounts = await respuestaModel.getResponseCountsByQuestionForTest(idTest);

	const responseCountByQuestion = responseCounts.reduce((acc, row) => {
		acc[Number(row.id_pregunta)] = Number(row.total_respuestas);
		return acc;
	}, {});

	const incompleteQuestions = activeQuestions.filter((question) => {
		return responseCountByQuestion[question.id_pregunta] !== 2;
	});

	if (incompleteQuestions.length > 0) {
		throw createServiceError(
			"Todas las preguntas deben tener exactamente 2 respuestas antes de finalizar el test",
			400,
		);
	}
};

const finalizeTest = async (uuid) => {
	const vocationalTest = await getOpenVocationalTestByUuid(uuid);
	const existingResult = await resultadoModel.getResultByTestId(vocationalTest.id_test);

	if (existingResult) {
		throw createServiceError("El test ya tiene un resultado generado", 409);
	}

	await validateCompletedTestResponses(vocationalTest.id_test);

	const rawScores = await respuestaModel.getRawScoresByDimensionForTest(
		vocationalTest.id_test,
	);
	const activeOptionCounts = await respuestaModel.getActiveOptionCountByDimension();
	const sortedScores = getSortedDimensionScores(rawScores, activeOptionCounts);
	const primaryProfileScore = sortedScores[0];
	const secondaryProfileScore = sortedScores[1] || null;

	const result = await sequelize.transaction(async (transaction) => {
		await resultadoModel.ensureBaseProfiles(transaction);

		const primaryProfile = await resultadoModel.getProfileByCode(
			primaryProfileScore.codigo,
			transaction,
		);
		const secondaryProfile = secondaryProfileScore
			? await resultadoModel.getProfileByCode(
					secondaryProfileScore.codigo,
					transaction,
				)
			: null;

		const storedScores = buildStoredScoresPayload(sortedScores);

		// Guarda el perfil dominante y conserva el detalle de puntuaciones para futuras ampliaciones.
		const savedResult = await resultadoModel.createTestResult(
			{
				idTest: vocationalTest.id_test,
				idPerfil: primaryProfile.id_perfil,
				puntuaciones: {
					...storedScores,
					perfil_principal: {
						codigo: primaryProfile.codigo,
						nombre: primaryProfile.nombre,
					},
					perfil_secundario: secondaryProfile
						? {
								codigo: secondaryProfile.codigo,
								nombre: secondaryProfile.nombre,
							}
						: null,
				},
			},
			transaction,
		);

		await testModel.finalizeTest(vocationalTest.id_test, transaction);

		return {
			id_resultado: savedResult.id_resultado,
			perfil_principal: {
				codigo: primaryProfile.codigo,
				nombre: primaryProfile.nombre,
				descripcion: primaryProfile.descripcion,
			},
			perfil_secundario: secondaryProfile
				? {
						codigo: secondaryProfile.codigo,
						nombre: secondaryProfile.nombre,
						descripcion: secondaryProfile.descripcion,
					}
				: null,
			puntuaciones: {
				brutas: storedScores.brutas,
				normalizadas: storedScores.normalizadas,
			},
		};
	});

	return result;
};

const getTestResponses = async (uuid) => {
	const vocationalTest = await testModel.getTestByUuid(uuid);

	if (!vocationalTest) {
		throw createServiceError("Test no encontrado", 404);
	}

	const responses = await respuestaModel.getResponsesByTestId(vocationalTest.id_test);

	return responses.map((response) => ({
		id_respuesta: response.id_respuesta,
		id_pregunta: response.id_pregunta,
		id_opcion: response.id_opcion,
		fecha_respuesta: response.fecha_respuesta,
	}));
};

const createTestResponse = async (uuid, payload) => {
	const idPregunta = Number(payload?.id_pregunta);
	const idOpcion = Number(payload?.id_opcion);

	if (!Number.isInteger(idPregunta) || !Number.isInteger(idOpcion)) {
		throw createServiceError(
			"Debes indicar id_pregunta e id_opcion con valores numericos",
			400,
		);
	}

	const vocationalTest = await getOpenVocationalTestByUuid(uuid);

	const question = await respuestaModel.getActiveQuestionById(idPregunta);

	if (!question) {
		throw createServiceError("La pregunta indicada no existe o no esta activa", 404);
	}

	const option = await respuestaModel.getActiveOptionByQuestion(idPregunta, idOpcion);

	if (!option) {
		throw createServiceError(
			"La opcion no corresponde a la pregunta indicada",
			400,
		);
	}

	const existingResponse = await respuestaModel.getResponseByTestAndOption(
		vocationalTest.id_test,
		idOpcion,
	);

	if (existingResponse) {
		throw createServiceError(
			"Esta opcion ya fue registrada en el test",
			409,
		);
	}

	const currentResponses = await respuestaModel.countResponsesByTestAndQuestion(
		vocationalTest.id_test,
		idPregunta,
	);

	if (currentResponses >= 2) {
		throw createServiceError(
			"Solo se permiten hasta 2 respuestas por pregunta",
			400,
		);
	}

	// Esta operacion implementa el registro de respuestas del cuestionario RIASEC.
	const savedResponse = await respuestaModel.createTestResponse({
		idTest: vocationalTest.id_test,
		idPregunta,
		idOpcion,
	});

	return {
		id_respuesta: savedResponse.id_respuesta,
		id_pregunta: savedResponse.id_pregunta,
		id_opcion: savedResponse.id_opcion,
	};
};

const updateTestResponse = async (uuid, idRespuesta, payload) => {
	const responseId = Number(idRespuesta);
	const idOpcion = Number(payload?.id_opcion);

	if (!Number.isInteger(responseId) || !Number.isInteger(idOpcion)) {
		throw createServiceError(
			"Debes indicar id_respuesta e id_opcion con valores numericos",
			400,
		);
	}

	const vocationalTest = await getOpenVocationalTestByUuid(uuid);

	const existingResponse = await respuestaModel.getResponseByIdAndTestId(
		responseId,
		vocationalTest.id_test,
	);

	if (!existingResponse) {
		throw createServiceError("Respuesta no encontrada para este test", 404);
	}

	const option = await respuestaModel.getActiveOptionByQuestion(
		existingResponse.id_pregunta,
		idOpcion,
	);

	if (!option) {
		throw createServiceError(
			"La opcion no corresponde a la pregunta indicada",
			400,
		);
	}

	const duplicatedOption = await respuestaModel.getResponseByTestAndOption(
		vocationalTest.id_test,
		idOpcion,
	);

	if (duplicatedOption && duplicatedOption.id_respuesta !== responseId) {
		throw createServiceError(
			"Esta opcion ya fue registrada en el test",
			409,
		);
	}

	// Sustituye una seleccion anterior por otra valida de la misma pregunta.
	const updatedResponse = await respuestaModel.updateTestResponse(
		responseId,
		idOpcion,
	);

	return {
		id_respuesta: updatedResponse.id_respuesta,
		id_pregunta: updatedResponse.id_pregunta,
		id_opcion: updatedResponse.id_opcion,
	};
};

const getTestByUuid = async (uuid) => {
	// Recupera la informacion minima necesaria para continuar el flujo del test.
	const vocationalTest = await testModel.getTestByUuid(uuid);

	if (!vocationalTest) {
		return null;
	}

	return {
		uuid: vocationalTest.uuid,
		estado: vocationalTest.estado,
		fecha_creacion: vocationalTest.fecha_creacion,
		fecha_finalizacion: vocationalTest.fecha_finalizacion,
	};
};

const createAnonymousTest = async () => {
	// Cada intento del test se identifica con un UUID unico y anonimo.
	const uuid = uuidv4();

	const createdTest = await testModel.createAnonymousTest(uuid);

	return {
		uuid: createdTest.uuid,
		estado: createdTest.estado,
	};
};

module.exports = {
	finalizeTest,
	updateTestResponse,
	createTestResponse,
	getTestResponses,
	getTestByUuid,
	createAnonymousTest,
};
