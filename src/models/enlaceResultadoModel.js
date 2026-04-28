/**
 * Gestiona los enlaces temporales para recuperar
 * el resultado de un test anonimo por medio de token protegiendo el UUID original del test.
 */
const { DataTypes, Op } = require("sequelize");
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
		token: {
			type: DataTypes.STRING(64),
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

// Guarda un enlace temporal asociado a un test finalizado con su correo y token visible.
const createResultLink = async ({ idTest, email, token, tokenHash, expirationDate }) => {
	return EnlaceResultado.create({
		id_test: idTest,
		email,
		token,
		token_hash: tokenHash,
		expira_en: expirationDate,
	});
};

// Recupera el ultimo enlace que siga vigente para poder reutilizarlo si ya existe.
const getActiveResultLinkByTestId = async (idTest) => {
	return EnlaceResultado.findOne({
		where: {
			id_test: idTest,
			expira_en: {
				[Op.gt]: new Date(),
			},
		},
		order: [["creado_en", "DESC"]],
	});
};

// Busca un enlace temporal por el hash del token recibido.
const getResultLinkByTokenHash = async (tokenHash) => {
	return EnlaceResultado.findOne({
		where: { token_hash: tokenHash },
	});
};

// Actualiza un enlace ya creado cuando hace falta completar o refrescar sus datos visibles.
const updateResultLink = async (
	resultLink,
	{ email, token, tokenHash, expirationDate },
) => {
	resultLink.email = email;
	resultLink.token = token;
	resultLink.token_hash = tokenHash;
	resultLink.expira_en = expirationDate;
	await resultLink.save();

	return resultLink;
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
	getActiveResultLinkByTestId,
	getResultLinkByTokenHash,
	updateResultLink,
	markResultLinkAsUsed,
};
