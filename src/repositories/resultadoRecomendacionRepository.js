/**
 * Consulta el catalogo formativo para construir recomendaciones asociadas
 * al resultado vocacional del test.
 */
const sequelize = require("../config/sequelize");

// Busca familias profesionales afines a los perfiles RIASEC mejor posicionados.
const getRecommendedFamiliesByProfileIds = async (profileIds, limit = 6) => {
	if (!profileIds || profileIds.length === 0) {
		return [];
	}

	const [rows] = await sequelize.query(
		`
			SELECT
				f.id_familia,
				f.nombre,
				f.descripcion,
				MAX(pfa.grado_afinidad) AS grado_afinidad
			FROM perfil_familia_afinidad pfa
			INNER JOIN familia_fp f ON f.id_familia = pfa.id_familia
			WHERE pfa.id_perfil IN (:profileIds)
			GROUP BY f.id_familia, f.nombre, f.descripcion
			ORDER BY grado_afinidad DESC, f.nombre ASC
			LIMIT :limit
		`,
		{
			replacements: { profileIds, limit },
		},
	);

	return rows;
};

// Calcula ciclos recomendados comparando los puntajes RIASEC del ciclo con el resultado del test.
const getRecommendedCyclesByRiasecScores = async (normalizedScores, limit = 8) => {
	if (!normalizedScores) {
		return [];
	}

	const [rows] = await sequelize.query(
		`
			SELECT
				c.id_ciclo,
				c.id_familia,
				c.codigo_oficial,
				c.nombre,
				c.nivel,
				c.descripcion,
				c.duracion_horas,
				f.nombre AS familia_nombre,
				(
					cra.puntaje_r * :scoreR +
					cra.puntaje_i * :scoreI +
					cra.puntaje_a * :scoreA +
					cra.puntaje_s * :scoreS +
					cra.puntaje_e * :scoreE +
					cra.puntaje_c * :scoreC
				) AS afinidad_riasec
			FROM ciclo_riasec_afinidad cra
			INNER JOIN ciclo_formativo c ON c.id_ciclo = cra.id_ciclo
			INNER JOIN familia_fp f ON f.id_familia = c.id_familia
			ORDER BY afinidad_riasec DESC, c.nombre ASC
			LIMIT :limit
		`,
		{
			replacements: {
				scoreR: Number(normalizedScores.R || 0),
				scoreI: Number(normalizedScores.I || 0),
				scoreA: Number(normalizedScores.A || 0),
				scoreS: Number(normalizedScores.S || 0),
				scoreE: Number(normalizedScores.E || 0),
				scoreC: Number(normalizedScores.C || 0),
				limit,
			},
		},
	);

	return rows;
};

module.exports = {
	getRecommendedFamiliesByProfileIds,
	getRecommendedCyclesByRiasecScores,
};
