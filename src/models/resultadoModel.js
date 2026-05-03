/**
 * Gestiona la persistencia del resultado final del test y asegura la
 * existencia del catalogo base de perfiles vocacionales del MVP.
 */
const { DataTypes } = require("sequelize");
const sequelize = require("../config/sequelize");

const Perfil = sequelize.define(
	"Perfil",
	{
		id_perfil: {
			type: DataTypes.SMALLINT.UNSIGNED,
			primaryKey: true,
		},
		codigo: {
			type: DataTypes.STRING(10),
			allowNull: false,
			unique: true,
		},
		nombre: {
			type: DataTypes.STRING(100),
			allowNull: false,
		},
		descripcion: {
			type: DataTypes.TEXT,
			allowNull: true,
		},
	},
	{
		tableName: "perfil",
		timestamps: false,
	},
);

const Resultado = sequelize.define(
	"Resultado",
	{
		id_resultado: {
			type: DataTypes.BIGINT.UNSIGNED,
			autoIncrement: true,
			primaryKey: true,
		},
		id_test: {
			type: DataTypes.BIGINT.UNSIGNED,
			allowNull: false,
			unique: true,
		},
		id_perfil: {
			type: DataTypes.SMALLINT.UNSIGNED,
			allowNull: false,
		},
		puntuaciones_json: {
			type: DataTypes.JSON,
			allowNull: true,
		},
		fecha_resultado: {
			type: DataTypes.DATE,
			allowNull: false,
			defaultValue: DataTypes.NOW,
		},
	},
	{
		tableName: "resultado",
		timestamps: false,
	},
);

// Relaciona el resultado guardado con el perfil principal calculado.
Resultado.belongsTo(Perfil, {
	foreignKey: "id_perfil",
	as: "perfil",
});

const BASE_PROFILES = [
	{ id_perfil: 1, codigo: "R" },
	{ id_perfil: 2, codigo: "I" },
	{ id_perfil: 3, codigo: "A" },
	{ id_perfil: 4, codigo: "S" },
	{ id_perfil: 5, codigo: "E" },
	{ id_perfil: 6, codigo: "C" },
];

const ensureBaseProfiles = async (transaction) => {
	for (const profile of BASE_PROFILES) {
		await Perfil.findOrCreate({
			where: { codigo: profile.codigo },
			defaults: profile,
			transaction,
		});
	}
};

const getProfileByCode = async (codigo, transaction) => {
	return Perfil.findOne({
		where: { codigo },
		transaction,
	});
};

const getResultByTestId = async (idTest) => {
	return Resultado.findOne({
		where: { id_test: idTest },
	});
};

const createTestResult = async (
	{ idTest, idPerfil, puntuaciones },
	transaction,
) => {
	return Resultado.create(
		{
			id_test: idTest,
			id_perfil: idPerfil,
			puntuaciones_json: puntuaciones,
		},
		{ transaction },
	);
};

const getResultDetailsByTestId = async (idTest) => {
	return Resultado.findOne({
		where: { id_test: idTest },
		include: [
			{
				model: Perfil,
				as: "perfil",
			},
		],
	});
};

module.exports = {
	BASE_PROFILES,
	Perfil,
	Resultado,
	ensureBaseProfiles,
	getProfileByCode,
	getResultByTestId,
	getResultDetailsByTestId,
	createTestResult,
};
