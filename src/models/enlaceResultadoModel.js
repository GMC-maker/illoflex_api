/**
 * Gestiona los enlaces temporales para recuperar
 * el resultado de un test anonimo por medio de token protegiendo el UUID original del test.
 */
const { DataTypes } = require("sequelize");
const sequelize = require("../config/sequelize");

const EnlaceResultado = sequelize.define(
	"EnlaceResultado",
	{
		id_enlace: {
			type: DataTypes.BIGINT.UNSIGNED,
			autoIncrement: true,
			primaryKey: true,
		},
		id_test: {
			type: DataTypes.BIGINT.UNSIGNED,
			allowNull: false,
		},
		email: {
			type: DataTypes.STRING(150),
			allowNull: true,
		},
		token_hash: {
			type: DataTypes.CHAR(64),
			allowNull: false,
			unique: true,
		},
		creado_en: {
			type: DataTypes.DATE,
			allowNull: false,
			defaultValue: DataTypes.NOW,
		},
		expira_en: {
			type: DataTypes.DATE,
			allowNull: false,
		},
		usado_en: {
			type: DataTypes.DATE,
			allowNull: true,
		},
	},
	{
		tableName: "enlace_resultado",
		timestamps: false,
	},
);

// Guarda un enlace temporal asociado a un test finalizado.
const createResultLink = async ({ idTest, tokenHash, expirationDate }) => {
	return EnlaceResultado.create({
		id_test: idTest,
		email: null,
		token_hash: tokenHash,
		expira_en: expirationDate,
	});
};

// Busca un enlace temporal por el hash del token recibido.
const getResultLinkByTokenHash = async (tokenHash) => {
	return EnlaceResultado.findOne({
		where: { token_hash: tokenHash },
	});
};

// Marca la primera vez que se usa el enlace, sin invalidarlo antes de caducar.
const markResultLinkAsUsed = async (resultLink) => {
	if (!resultLink.usado_en) {
		resultLink.usado_en = new Date();
		await resultLink.save();
	}

	return resultLink;
};

module.exports = {
	EnlaceResultado,
	createResultLink,
	getResultLinkByTokenHash,
	markResultLinkAsUsed,
};
