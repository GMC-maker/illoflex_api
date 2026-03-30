/**
 * Recibe las peticiones HTTP del recurso test y delega la logica de negocio
 * en la capa service para responder con JSON consistente.
 */
const testService = require("../services/testService");

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
	updateTestResponse,
	createTestResponse,
	getTestResponses,
	getTestByUuid,
	createAnonymousTest,
};
