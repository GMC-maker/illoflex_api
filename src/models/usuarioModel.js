/**
 * Define el modelo Sequelize de la tabla usuario y expone las operaciones
 * minimas necesarias para la futura autenticacion del area admin.
 */
const { DataTypes } = require("sequelize");
const sequelize = require("../config/sequelize");

const Usuario = sequelize.define(
	"Usuario",
	{
		id_usuario: {
			type: DataTypes.INTEGER.UNSIGNED,
			autoIncrement: true,
			primaryKey: true,
		},
		email: {
			type: DataTypes.STRING(150),
			allowNull: false,
			unique: true,
		},
		password_hash: {
			type: DataTypes.STRING(255),
			allowNull: true,
		},
		rol: {
			type: DataTypes.ENUM("ADMIN", "NORMAL"),
			allowNull: false,
			defaultValue: "NORMAL",
		},
		fecha_registro: {
			type: DataTypes.DATE,
			allowNull: false,
			defaultValue: DataTypes.NOW,
		},
	},
	{
		tableName: "usuario",
		timestamps: false,
	},
);

const getAdminByEmail = async (email) => {
	return Usuario.findOne({
		where: {
			email,
			rol: "ADMIN",
		},
	});
};

const getAdminById = async (idUsuario) => {
	return Usuario.findOne({
		where: {
			id_usuario: idUsuario,
			rol: "ADMIN",
		},
	});
};

module.exports = {
	Usuario,
	getAdminByEmail,
	getAdminById,
};
