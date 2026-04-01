/**
 * Define los modelos Sequelize relacionados con las respuestas del test:
 * preguntas, opciones y respuestas registradas por el usuario.
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

module.exports = {
	Respuesta,
	Pregunta,
	Opcion,
};
