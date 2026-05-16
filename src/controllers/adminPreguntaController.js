/** Recibe las peticiones HTTP del listado de admin de preguntas */
const adminPreguntaService = require("../services/adminPreguntaService");

// Recupera todas las preguntas del test con sus opciones
const getAllQuestions = async (req, res) => {
	try {
		const questions = await adminPreguntaService.getAllQuestions();

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

// Actualiza una pregunta existente con sus opciones asociadas.
const updateQuestion = async (req, res) => {
	try {
		const updatedQuestion = await adminPreguntaService.updateQuestion(
			req.params.idPregunta,
			req.body,
		);

		return res.status(200).json({
			ok: true,
			datos: updatedQuestion,
			mensaje: "Pregunta actualizada correctamente",
		});
	} catch (error) {
		return res.status(error.statusCode || 500).json({
			ok: false,
			datos: null,
			mensaje: error.message || "No se pudo actualizar la pregunta",
		});
	}
};

module.exports = {
	getAllQuestions,
	updateQuestion,
};
