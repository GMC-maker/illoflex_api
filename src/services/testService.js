/**
 * Contiene la logica de negocio del recurso test.
 * Aqui se validan las reglas del cuestionario y se generan los datos
 * necesarios antes de persistirlos.
 */
const { v4: uuidv4 } = require("uuid");
const sequelize = require("../config/sequelize");
const respuestaRepository = require("../repositories/respuestaRepository");
const resultadoModel = require("../models/resultadoModel");
const testModel = require("../models/testModel");

// Centraliza la creacion de errores de negocio con su codigo HTTP asociado.
const createServiceError = (message, statusCode) => {
	const error = new Error(message);
	error.statusCode = statusCode;
	return error;
};

// Recupera un test en curso y evita operar sobre tests inexistentes o ya cerrados.
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

// Calcula y ordena los perfiles RIASEC a partir de las respuestas y las opciones activas.
const calculateAndRankProfiles = (
	rawScoresByDimension,
	totalOptionsPerDimension,
) => {
	const activeOptionsByCode = totalOptionsPerDimension.reduce((acc, row) => {
		acc[row.codigo] = Number(row.total_opciones);
		return acc;
	}, {});

	const profilesScoreMap = resultadoModel.BASE_PROFILES.reduce((acc, profile) => {
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

	for (const row of rawScoresByDimension) {
		const code = row.codigo;
		const rawScore = Number(row.puntuacion);
		const totalOptions = profilesScoreMap[code].total_opciones_activas;

		profilesScoreMap[code].puntuacion_bruta = rawScore;
		profilesScoreMap[code].puntuacion_normalizada =
			totalOptions > 0 ? Number((rawScore / totalOptions).toFixed(4)) : 0;
	}

	// Normaliza para compensar dimensiones con diferente numero de opciones activas.
	return Object.values(profilesScoreMap).sort((left, right) => {
		if (right.puntuacion_normalizada !== left.puntuacion_normalizada) {
			return right.puntuacion_normalizada - left.puntuacion_normalizada;
		}

		if (right.puntuacion_bruta !== left.puntuacion_bruta) {
			return right.puntuacion_bruta - left.puntuacion_bruta;
		}

		return left.codigo.localeCompare(right.codigo);
	});
};

// Construye el resumen de puntuaciones que se guardara junto al resultado del test.
const buildResultScoreSummary = (rankedProfiles) => {
	const rawScoresByDimension = {};
	const normalizedScores = {};

	for (const score of rankedProfiles) {
		rawScoresByDimension[score.codigo] = score.puntuacion_bruta;
		normalizedScores[score.codigo] = score.puntuacion_normalizada;
	}

	return {
		brutas: rawScoresByDimension,
		normalizadas: normalizedScores,
		ranking: rankedProfiles.map((score, index) => ({
			posicion: index + 1,
			codigo: score.codigo,
			nombre: score.nombre,
			puntuacion_bruta: score.puntuacion_bruta,
			puntuacion_normalizada: score.puntuacion_normalizada,
		})),
	};
};

// Comprueba que todas las preguntas activas tengan exactamente dos respuestas antes de cerrar el test.
const validateCompletedTestResponses = async (idTest) => {
	const activeQuestions = await respuestaRepository.getActiveQuestions();
	const responseCounts =
		await respuestaRepository.getResponseCountsByQuestionForTest(idTest);

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

// Completa el test, genera el resultado vocacional y deja persistido el resumen de puntuaciones.
const completeTestGenerateResult = async (uuid) => {
	const vocationalTest = await getOpenVocationalTestByUuid(uuid);
	const existingResult = await resultadoModel.getResultByTestId(vocationalTest.id_test);

	if (existingResult) {
		throw createServiceError("El test ya tiene un resultado generado", 409);
	}

	await validateCompletedTestResponses(vocationalTest.id_test);

	const rawScoresByDimension =
		await respuestaRepository.getRawScoresByDimensionForTest(
		vocationalTest.id_test,
		);
	const totalOptionsPerDimension =
		await respuestaRepository.getActiveOptionCountByDimension();
	const rankedProfiles = calculateAndRankProfiles(
		rawScoresByDimension,
		totalOptionsPerDimension,
	);
	const primaryProfileScore = rankedProfiles[0];
	const secondaryProfileScore = rankedProfiles[1] || null;

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

		const storedScores = buildResultScoreSummary(rankedProfiles);

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

// Devuelve las preguntas activas con sus opciones para que el frontend recorra el cuestionario.
const getTestQuestions = async (uuid) => {
	await getOpenVocationalTestByUuid(uuid);
	const questions = await respuestaRepository.getActiveQuestionsWithOptions();

	return questions.map((question) => ({
		id_pregunta: question.id_pregunta,
		enunciado: question.enunciado,
		orden: question.orden,
		opciones: question.opciones.map((option) => ({
			id_opcion: option.id_opcion,
			texto: option.texto,
		})),
	}));
};

// Recupera las respuestas ya guardadas para reconstruir el estado del test en cliente.
const getTestResponses = async (uuid) => {
	const vocationalTest = await testModel.getTestByUuid(uuid);

	if (!vocationalTest) {
		throw createServiceError("Test no encontrado", 404);
	}

	const responses = await respuestaRepository.getResponsesByTestId(
		vocationalTest.id_test,
	);

	return responses.map((response) => ({
		id_respuesta: response.id_respuesta,
		id_pregunta: response.id_pregunta,
		id_opcion: response.id_opcion,
		fecha_respuesta: response.fecha_respuesta,
	}));
};

// Registra una nueva respuesta validando que la opcion pertenezca a la pregunta y no duplique seleccion.
// responseData contiene id_pregunta e id_opcion, representando los datos de una respuesta del test.
const createTestResponse = async (uuid, responseData) => {
	const idPregunta = Number(responseData?.id_pregunta);
	const idOpcion = Number(responseData?.id_opcion);

	if (!Number.isInteger(idPregunta) || !Number.isInteger(idOpcion)) {
		throw createServiceError(
			"Debes indicar id_pregunta e id_opcion con valores numericos",
			400,
		);
	}

	const vocationalTest = await getOpenVocationalTestByUuid(uuid);

	const question = await respuestaRepository.getActiveQuestionById(idPregunta);

	if (!question) {
		throw createServiceError("La pregunta indicada no existe o no esta activa", 404);
	}

	const option = await respuestaRepository.getActiveOptionByQuestion(
		idPregunta,
		idOpcion,
	);

	if (!option) {
		throw createServiceError(
			"La opcion no corresponde a la pregunta indicada",
			400,
		);
	}

	// El duplicado solo se comprueba dentro de la pregunta actual del test.
	const existingResponse =
		await respuestaRepository.getResponseByTestQuestionAndOption(
		vocationalTest.id_test,
		idPregunta,
		idOpcion,
		);

	if (existingResponse) {
		throw createServiceError(
			"Esta opcion ya fue registrada en el test",
			409,
		);
	}

	const currentResponses =
		await respuestaRepository.countResponsesByTestAndQuestion(
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
	const savedResponse = await respuestaRepository.createTestResponse({
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

// Sustituye una respuesta existente por otra opcion valida de la misma pregunta.
// responseData contiene id_opcion como dato necesario para sustituir una respuesta existente del test.
const updateTestResponse = async (uuid, idRespuesta, responseData) => {
	const responseId = Number(idRespuesta);
	const idOpcion = Number(responseData?.id_opcion);

	if (!Number.isInteger(responseId) || !Number.isInteger(idOpcion)) {
		throw createServiceError(
			"Debes indicar id_respuesta e id_opcion con valores numericos",
			400,
		);
	}

	const vocationalTest = await getOpenVocationalTestByUuid(uuid);

	const existingResponse = await respuestaRepository.getResponseByIdAndTestId(
		responseId,
		vocationalTest.id_test,
	);

	if (!existingResponse) {
		throw createServiceError("Respuesta no encontrada para este test", 404);
	}

	const option = await respuestaRepository.getActiveOptionByQuestion(
		existingResponse.id_pregunta,
		idOpcion,
	);

	if (!option) {
		throw createServiceError(
			"La opcion no corresponde a la pregunta indicada",
			400,
		);
	}

	// Al editar, solo bloquea que las dos respuestas actuales de la misma
	// pregunta queden duplicadas al mismo tiempo.
	const duplicatedOption =
		await respuestaRepository.getResponseByTestQuestionAndOption(
			vocationalTest.id_test,
			existingResponse.id_pregunta,
			idOpcion,
		);

	if (duplicatedOption && duplicatedOption.id_respuesta !== responseId) {
		throw createServiceError(
			"Esta opcion ya fue registrada en el test",
			409,
		);
	}

	// Sustituye una seleccion anterior por otra valida de la misma pregunta.
	const updatedResponse = await respuestaRepository.updateTestResponse(
		responseId,
		idOpcion,
	);

	return {
		id_respuesta: updatedResponse.id_respuesta,
		id_pregunta: updatedResponse.id_pregunta,
		id_opcion: updatedResponse.id_opcion,
	};
};

// Recupera la informacion minima del test necesaria para continuar el flujo o consultar su estado.
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

// Crea un nuevo test anonimo y genera el UUID que identificara ese intento.
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
	completeTestGenerateResult,
	getTestQuestions,
	updateTestResponse,
	createTestResponse,
	getTestResponses,
	getTestByUuid,
	createAnonymousTest,
};
