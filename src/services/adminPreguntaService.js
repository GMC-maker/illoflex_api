const adminPreguntaRepository = require("../repositories/adminPreguntaRepository");

//solo queremos obtener el listado de preguntas con sus respuestas asociadas.
const getAllQuestions = async () => {
	return adminPreguntaRepository.getAllQuestionsWithOptions();
};

//calculo o contador de tipos de preguntas:
module.exports = {
	getAllQuestions,
};
