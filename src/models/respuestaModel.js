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
		enunciado: {
			type: DataTypes.STRING(255),
			allowNull: false,
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
		texto: {
			type: DataTypes.STRING(255),
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

Pregunta.hasMany(Opcion, {
	foreignKey: "id_pregunta",
	as: "opciones",
});

Opcion.belongsTo(Pregunta, {
	foreignKey: "id_pregunta",
});

module.exports = {
	Respuesta,
	Pregunta,
	Opcion,
};
