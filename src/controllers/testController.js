/**
 * Recibe las peticiones HTTP del recurso test y delega la logica de negocio
 * en la capa service para responder con JSON consistente.
 */
const testService = require("../services/testService");

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
	createAnonymousTest,
};
