/**
 * Define el modelo Sequelize de la tabla test y encapsula el acceso
 * a los datos del test vocacional anonimo.
 */
const { DataTypes } = require("sequelize");
const sequelize = require("../config/sequelize");

const Test = sequelize.define(
	"Test",
	{
		id_test: {
			type: DataTypes.BIGINT.UNSIGNED,
			autoIncrement: true,
			primaryKey: true,
		},
		uuid: {
			type: DataTypes.CHAR(36),
			allowNull: false,
			unique: true,
		},
		id_usuario: {
			type: DataTypes.INTEGER.UNSIGNED,
			allowNull: true,
		},
		estado: {
			type: DataTypes.ENUM("EN_PROGRESO", "FINALIZADO"),
			allowNull: false,
			defaultValue: "EN_PROGRESO",
		},
		fecha_creacion: {
			type: DataTypes.DATE,
			allowNull: false,
			defaultValue: DataTypes.NOW,
		},
		fecha_finalizacion: {
			type: DataTypes.DATE,
			allowNull: true,
		},
	},
	{
		tableName: "test",
		timestamps: false,
	},
);

const createAnonymousTest = async (uuid) => {
	// Inserta el test anonimo respetando los valores por defecto del esquema.
	return Test.create({
		uuid,
		id_usuario: null,
		estado: "EN_PROGRESO",
	});
};

module.exports = {
	Test,
	createAnonymousTest,
};
