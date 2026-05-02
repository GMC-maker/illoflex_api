/**
 * Recibe las peticiones HTTP para crear y consultar enlaces temporales
 * de resultados del test vocacional.
 */
const enlaceResultadoService = require("../services/enlaceResultadoService");

// Genera un enlace temporal para recuperar el resultado de un test finalizado.
const createTemporaryResultLink = async (req, res) => {
	try {
		const { email } = req.body || {};

		const resultLink = await enlaceResultadoService.createTemporaryResultLink(
			req.params.uuid,
			email,
		);

		return res.status(201).json({
			ok: true,
			datos: resultLink,
			mensaje: "Enlace temporal generado correctamente",
		});
	} catch (error) {
		return res.status(error.statusCode || 500).json({
			ok: false,
			datos: null,
			mensaje: error.message || "No se pudo generar el enlace temporal",
		});
	}
};

// Recupera el resultado asociado a un token temporal valido.
const getResultByTemporaryToken = async (req, res) => {
	try {
		const result = await enlaceResultadoService.getResultByTemporaryToken(
			req.params.token,
		);

		return res.status(200).json({
			ok: true,
			datos: result,
			mensaje: "Resultado recuperado correctamente",
		});
	} catch (error) {
		return res.status(error.statusCode || 500).json({
			ok: false,
			datos: null,
			mensaje: error.message || "No se pudo recuperar el resultado",
		});
	}
};

module.exports = {
	createTemporaryResultLink,
	getResultByTemporaryToken,
};
