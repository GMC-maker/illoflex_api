/**
 * Contiene la logica de negocio del recurso test.
 * Aqui se validan las reglas del cuestionario y se generan los datos
 * necesarios antes de persistirlos.
 */
const { v4: uuidv4 } = require("uuid");
const respuestaModel = require("../models/respuestaModel");
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
	updateTestResponse,
	createTestResponse,
	getTestResponses,
	getTestByUuid,
	createAnonymousTest,
};
