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

const createTestResponse = async ({ idTest, idPregunta, idOpcion }) => {
	// Inserta una seleccion del usuario para una pregunta concreta del test.
	return Respuesta.create({
		id_test: idTest,
		id_pregunta: idPregunta,
		id_opcion: idOpcion,
	});
};

module.exports = {
	Respuesta,
	getActiveQuestionById,
	getActiveOptionByQuestion,
	countResponsesByTestAndQuestion,
	getResponseByTestAndOption,
	createTestResponse,
};
