/**
 * Centraliza el acceso a datos relacionado con las respuestas del test y
 * con las validaciones de persistencia necesarias sobre preguntas y opciones.
 */
const { DataTypes } = require("sequelize");
const sequelize = require("../config/sequelize");

const Pregunta = sequelize.define(
	"Pregunta",
	{
		id_pregunta: {
			type: DataTypes.INTEGER.UNSIGNED,
			primaryKey: true,
		},
		orden: {
			type: DataTypes.SMALLINT.UNSIGNED,
			allowNull: true,
		},
		activa: {
			type: DataTypes.BOOLEAN,
			allowNull: false,
		},
	},
	{
		tableName: "pregunta",
		timestamps: false,
	},
);

const Opcion = sequelize.define(
	"Opcion",
	{
		id_opcion: {
			type: DataTypes.INTEGER.UNSIGNED,
			primaryKey: true,
		},
		id_pregunta: {
			type: DataTypes.INTEGER.UNSIGNED,
			allowNull: false,
		},
		id_dimension: {
			type: DataTypes.TINYINT.UNSIGNED,
			allowNull: false,
		},
		activa: {
			type: DataTypes.BOOLEAN,
			allowNull: false,
		},
	},
	{
		tableName: "opcion",
		timestamps: false,
	},
);

const Respuesta = sequelize.define(
	"Respuesta",
	{
		id_respuesta: {
			type: DataTypes.BIGINT.UNSIGNED,
			autoIncrement: true,
			primaryKey: true,
		},
		id_test: {
			type: DataTypes.BIGINT.UNSIGNED,
			allowNull: false,
		},
		id_pregunta: {
			type: DataTypes.INTEGER.UNSIGNED,
			allowNull: false,
		},
		id_opcion: {
			type: DataTypes.INTEGER.UNSIGNED,
			allowNull: false,
		},
		fecha_respuesta: {
			type: DataTypes.DATE,
			allowNull: false,
			defaultValue: DataTypes.NOW,
		},
	},
	{
		tableName: "respuesta",
		timestamps: false,
	},
);

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

const getResponseByTestAndOption = async (idTest, idOpcion) => {
	return Respuesta.findOne({
		where: {
			id_test: idTest,
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
	Respuesta,
	getActiveQuestionById,
	getActiveQuestions,
	getActiveOptionByQuestion,
	getActiveOptionCountByDimension,
	getRawScoresByDimensionForTest,
	countResponsesByTestAndQuestion,
	getResponseCountsByQuestionForTest,
	getResponseByTestAndOption,
	getResponsesByTestId,
	getResponseByIdAndTestId,
	createTestResponse,
	updateTestResponse,
};
