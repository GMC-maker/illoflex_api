/**
 * Recibe las peticiones HTTP del recurso test y delega la logica de negocio
 * en la capa service para responder con JSON consistente.
 */
const testService = require("../services/testService");

// Cierra el test y devuelve al cliente el resultado vocacional calculado.
const finalizeTest = async (req, res) => {
	try {
		// Cierra el test y devuelve el perfil vocacional calculado.
		const result = await testService.completeTestGenerateResult(req.params.uuid);

		return res.status(200).json({
			ok: true,
			datos: result,
			mensaje: "Test finalizado correctamente",
		});
	} catch (error) {
		return res.status(error.statusCode || 500).json({
			ok: false,
			datos: null,
			mensaje: error.message || "No se pudo finalizar el test",
		});
	}
};

// Entrega las preguntas activas del test con sus opciones listas para mostrarse en el frontend.
const getTestQuestions = async (req, res) => {
	try {
		const questions = await testService.getTestQuestions(req.params.uuid);

		return res.status(200).json({
			ok: true,
			datos: questions,
			mensaje: "Preguntas recuperadas correctamente",
		});
	} catch (error) {
		return res.status(error.statusCode || 500).json({
			ok: false,
			datos: null,
			mensaje: error.message || "No se pudieron recuperar las preguntas",
		});
	}
};

// Actualiza una respuesta ya existente del test manteniendo la validacion en la capa service.
const updateTestResponse = async (req, res) => {
	try {
		// Permite cambiar una respuesta ya registrada antes de finalizar el test.
		const updatedResponse = await testService.updateTestResponse(
			req.params.uuid,
			req.params.id_respuesta,
			req.body,
		);

		return res.status(200).json({
			ok: true,
			datos: updatedResponse,
			mensaje: "Respuesta actualizada correctamente",
		});
	} catch (error) {
		return res.status(error.statusCode || 500).json({
			ok: false,
			datos: null,
			mensaje: error.message || "No se pudo actualizar la respuesta",
		});
	}
};

// Registra una nueva respuesta del usuario para una pregunta concreta del cuestionario.
const createTestResponse = async (req, res) => {
	try {
		// Registra una respuesta del test respetando las reglas del cuestionario.
		const savedResponse = await testService.createTestResponse(
			req.params.uuid,
			req.body,
		);

		return res.status(201).json({
			ok: true,
			datos: savedResponse,
			mensaje: "Respuesta registrada correctamente",
		});
	} catch (error) {
		return res.status(error.statusCode || 500).json({
			ok: false,
			datos: null,
			mensaje: error.message || "No se pudo registrar la respuesta",
		});
	}
};


const getTestResponses = async (req, res) => {
	try {
		// Devuelve las respuestas para que el cliente pueda reconstruir el test.
		const responses = await testService.getTestResponses(req.params.uuid);

		return res.status(200).json({
			ok: true,
			datos: responses,
			mensaje: "Respuestas recuperadas correctamente",
		});
	} catch (error) {
		return res.status(error.statusCode || 500).json({
			ok: false,
			datos: null,
			mensaje: error.message || "No se pudieron recuperar las respuestas",
		});
	}
};

// Recupera un test anonimo por UUID y expone solo la informacion minima necesaria.
const getTestByUuid = async (req, res) => {
	try {
		// Este endpoint permite recuperar un intento concreto del test anonimo.
		const vocationalTest = await testService.getTestByUuid(req.params.uuid);

		if (!vocationalTest) {
			return res.status(404).json({
				ok: false,
				datos: null,
				mensaje: "Test no encontrado",
			});
		}

		return res.status(200).json({
			ok: true,
			datos: vocationalTest,
			mensaje: "Test recuperado correctamente",
		});
	} catch (error) {
		return res.status(500).json({
			ok: false,
			datos: null,
			mensaje: "No se pudo recuperar el test",
		});
	}
};

// Inicia un nuevo test anonimo y devuelve el identificador con el que seguira el flujo.
const createAnonymousTest = async (req, res) => {
	try {
		// El controller solo coordina la peticion y la respuesta.
		const vocationalTest = await testService.createAnonymousTest();

		return res.status(201).json({
			ok: true,
			datos: vocationalTest,
			mensaje: "Test iniciado correctamente",
		});
	} catch (error) {
		return res.status(500).json({
			ok: false,
			datos: null,
			mensaje: "No se pudo iniciar el test",
		});
	}
};

module.exports = {
	finalizeTest,
	getTestQuestions,
	updateTestResponse,
	createTestResponse,
	getTestResponses,
	getTestByUuid,
	createAnonymousTest,
};
