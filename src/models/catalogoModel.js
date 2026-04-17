/**
 * Define los modelos Sequelize del catalogo formativo usado para
 * construir recomendaciones a partir del resultado RIASEC.
 */
const { DataTypes } = require("sequelize");
const sequelize = require("../config/sequelize");

const FamiliaFp = sequelize.define(
	"FamiliaFp",
	{
		id_familia: {
			type: DataTypes.SMALLINT.UNSIGNED,
			primaryKey: true,
		},
		nombre: {
			type: DataTypes.STRING(120),
			allowNull: false,
		},
		descripcion: {
			type: DataTypes.TEXT,
			allowNull: true,
		},
	},
	{
		tableName: "familia_fp",
		timestamps: false,
	},
);

const CicloFormativo = sequelize.define(
	"CicloFormativo",
	{
		id_ciclo: {
			type: DataTypes.INTEGER.UNSIGNED,
			primaryKey: true,
		},
		id_familia: {
			type: DataTypes.SMALLINT.UNSIGNED,
			allowNull: false,
		},
		codigo_oficial: {
			type: DataTypes.STRING(30),
			allowNull: true,
		},
		nombre: {
			type: DataTypes.STRING(180),
			allowNull: false,
		},
		nivel: {
			type: DataTypes.STRING(60),
			allowNull: false,
		},
		descripcion: {
			type: DataTypes.TEXT,
			allowNull: true,
		},
		duracion_horas: {
			type: DataTypes.SMALLINT.UNSIGNED,
			allowNull: true,
		},
	},
	{
		tableName: "ciclo_formativo",
		timestamps: false,
	},
);

const PerfilFamiliaAfinidad = sequelize.define(
	"PerfilFamiliaAfinidad",
	{
		id_perfil: {
			type: DataTypes.SMALLINT.UNSIGNED,
			primaryKey: true,
		},
		id_familia: {
			type: DataTypes.SMALLINT.UNSIGNED,
			primaryKey: true,
		},
		grado_afinidad: {
			type: DataTypes.TINYINT.UNSIGNED,
			allowNull: false,
		},
	},
	{
		tableName: "perfil_familia_afinidad",
		timestamps: false,
	},
);

const CicloRiasecAfinidad = sequelize.define(
	"CicloRiasecAfinidad",
	{
		id_ciclo: {
			type: DataTypes.INTEGER.UNSIGNED,
			primaryKey: true,
		},
		puntaje_r: {
			type: DataTypes.TINYINT.UNSIGNED,
			allowNull: false,
		},
		puntaje_i: {
			type: DataTypes.TINYINT.UNSIGNED,
			allowNull: false,
		},
		puntaje_a: {
			type: DataTypes.TINYINT.UNSIGNED,
			allowNull: false,
		},
		puntaje_s: {
			type: DataTypes.TINYINT.UNSIGNED,
			allowNull: false,
		},
		puntaje_e: {
			type: DataTypes.TINYINT.UNSIGNED,
			allowNull: false,
		},
		puntaje_c: {
			type: DataTypes.TINYINT.UNSIGNED,
			allowNull: false,
		},
	},
	{
		tableName: "ciclo_riasec_afinidad",
		timestamps: false,
	},
);

// Una familia profesional puede contener varios ciclos formativos.
FamiliaFp.hasMany(CicloFormativo, {
	foreignKey: "id_familia",
	as: "ciclos",
});

CicloFormativo.belongsTo(FamiliaFp, {
	foreignKey: "id_familia",
	as: "familia",
});

// Cada ciclo puede tener una matriz de afinidad RIASEC asociada.
CicloFormativo.hasOne(CicloRiasecAfinidad, {
	foreignKey: "id_ciclo",
	as: "afinidad_riasec",
});

CicloRiasecAfinidad.belongsTo(CicloFormativo, {
	foreignKey: "id_ciclo",
	as: "ciclo",
});

// La afinidad perfil-familia conecta cada perfil RIASEC con familias profesionales.
FamiliaFp.hasMany(PerfilFamiliaAfinidad, {
	foreignKey: "id_familia",
	as: "afinidades_perfil",
});

PerfilFamiliaAfinidad.belongsTo(FamiliaFp, {
	foreignKey: "id_familia",
	as: "familia",
});

module.exports = {
	FamiliaFp,
	CicloFormativo,
	PerfilFamiliaAfinidad,
	CicloRiasecAfinidad,
};
