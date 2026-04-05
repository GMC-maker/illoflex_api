/**
 * Centraliza el acceso a datos relacionado con las respuestas del test,
 * reutilizando los modelos Sequelize definidos en la capa models.
 * Las consultas de duplicados se resuelven por pregunta para respetar
 * el estado actual de sus dos selecciones.
 */
const sequelize = require("../config/sequelize");
const {
	Pregunta,
	Opcion,
	Respuesta,
} = require("../models/respuestaModel");

const getActiveQuestionById = async (idPregunta) => {
	return Pregunta.findOne({
		where: {
			id_pregunta: idPregunta,
			activa: true,
		},
	});
};

const getActiveOptionByQuestion = async (idPregunta, idOpcion) => {
	return Opcion.findOne({
		where: {
			id_opcion: idOpcion,
			id_pregunta: idPregunta,
			activa: true,
		},
	});
};

const countResponsesByTestAndQuestion = async (idTest, idPregunta) => {
	return Respuesta.count({
		where: {
			id_test: idTest,
			id_pregunta: idPregunta,
		},
	});
};

const getResponseByTestQuestionAndOption = async (
	idTest,
	idPregunta,
	idOpcion,
) => {
	return Respuesta.findOne({
		where: {
			id_test: idTest,
			id_pregunta: idPregunta,
			id_opcion: idOpcion,
		},
	});
};

const getActiveQuestions = async () => {
	return Pregunta.findAll({
		where: { activa: true },
		order: [["orden", "ASC"]],
	});
};

const getResponsesByTestId = async (idTest) => {
	return Respuesta.findAll({
		where: {
			id_test: idTest,
		},
		order: [
			["id_pregunta", "ASC"],
			["id_respuesta", "ASC"],
		],
	});
};

const getResponseCountsByQuestionForTest = async (idTest) => {
	const [rows] = await sequelize.query(
		`
			SELECT id_pregunta, COUNT(*) AS total_respuestas
			FROM respuesta
			WHERE id_test = ?
			GROUP BY id_pregunta
		`,
		{
			replacements: [idTest],
		},
	);

	return rows;
};

const getResponseByIdAndTestId = async (idRespuesta, idTest) => {
	return Respuesta.findOne({
		where: {
			id_respuesta: idRespuesta,
			id_test: idTest,
		},
	});
};

const getRawScoresByDimensionForTest = async (idTest) => {
	const [rows] = await sequelize.query(
		`
			SELECT o.id_dimension, d.codigo, COUNT(*) AS puntuacion
			FROM respuesta r
			INNER JOIN opcion o ON o.id_opcion = r.id_opcion
			INNER JOIN dimension_riasec d ON d.id_dimension = o.id_dimension
			WHERE r.id_test = ?
			GROUP BY o.id_dimension, d.codigo
		`,
		{
			replacements: [idTest],
		},
	);

	return rows;
};

const getActiveOptionCountByDimension = async () => {
	const [rows] = await sequelize.query(`
		SELECT o.id_dimension, d.codigo, COUNT(*) AS total_opciones
		FROM opcion o
		INNER JOIN pregunta p ON p.id_pregunta = o.id_pregunta
		INNER JOIN dimension_riasec d ON d.id_dimension = o.id_dimension
		WHERE o.activa = 1 AND p.activa = 1
		GROUP BY o.id_dimension, d.codigo
	`);

	return rows;
};

const createTestResponse = async ({ idTest, idPregunta, idOpcion }) => {
	// Inserta una seleccion del usuario para una pregunta concreta del test.
	return Respuesta.create({
		id_test: idTest,
		id_pregunta: idPregunta,
		id_opcion: idOpcion,
	});
};

const updateTestResponse = async (idRespuesta, idOpcion) => {
	const response = await Respuesta.findByPk(idRespuesta);

	response.id_opcion = idOpcion;
	await response.save();

	return response;
};

module.exports = {
	getActiveQuestionById,
	getActiveOptionByQuestion,
	countResponsesByTestAndQuestion,
	getResponseByTestQuestionAndOption,
	getActiveQuestions,
	getResponsesByTestId,
	getResponseCountsByQuestionForTest,
	getResponseByIdAndTestId,
	getRawScoresByDimensionForTest,
	getActiveOptionCountByDimension,
	createTestResponse,
	updateTestResponse,
};
