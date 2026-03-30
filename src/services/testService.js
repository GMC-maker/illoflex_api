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

const createTestResponse = async (uuid, payload) => {
	const idPregunta = Number(payload?.id_pregunta);
	const idOpcion = Number(payload?.id_opcion);

	if (!Number.isInteger(idPregunta) || !Number.isInteger(idOpcion)) {
		throw createServiceError(
			"Debes indicar id_pregunta e id_opcion con valores numericos",
			400,
		);
	}

	const vocationalTest = await testModel.getTestByUuid(uuid);

	if (!vocationalTest) {
		throw createServiceError("Test no encontrado", 404);
	}

	if (vocationalTest.estado !== "EN_PROGRESO") {
		throw createServiceError("El test ya no admite respuestas", 409);
	}

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
	createTestResponse,
	getTestByUuid,
	createAnonymousTest,
};
