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

const getTestByUuid = async (uuid) => {
	// Busca el test por su UUID para no exponer el identificador interno de la BD.
	return Test.findOne({
		where: { uuid },
	});
};

const finalizeTest = async (idTest, transaction) => {
	const vocationalTest = await Test.findByPk(idTest, { transaction });

	vocationalTest.estado = "FINALIZADO";
	vocationalTest.fecha_finalizacion = new Date();
	await vocationalTest.save({ transaction });

	return vocationalTest;
};

module.exports = {
	Test,
	finalizeTest,
	getTestByUuid,
	createAnonymousTest,
};
