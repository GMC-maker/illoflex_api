
const sequelize = require("../config/sequelize");

const getAllQuestionsWithOptions = async () => {
	const [rows] = await sequelize.query(`
        SELECT
            p.id_pregunta,
            p.enunciado,
            p.orden,
            p.activa AS pregunta_activa,
            o.id_opcion,
            o.texto,
            o.activa AS opcion_activa,
            o.id_dimension,
            d.codigo AS dimension_codigo,
            d.nombre AS dimension_nombre
        FROM pregunta p
        LEFT JOIN opcion o 
        ON o.id_pregunta = p.id_pregunta
        LEFT JOIN dimension_riasec d
        ON d.id_dimension = o.id_dimension
        ORDER BY p.orden ASC, p.id_pregunta ASC, o.id_opcion ASC
    `);

	const questionMap = new Map();

	for (const row of rows) {
		if (!questionMap.has(row.id_pregunta)) {
			questionMap.set(row.id_pregunta, {
				id_pregunta: row.id_pregunta,
				enunciado: row.enunciado,
				orden: row.orden,
				activa: Boolean(row.pregunta_activa),
				opciones: [],
			});
		}

		if (row.id_opcion) {
			questionMap.get(row.id_pregunta).opciones.push({
				id_opcion: row.id_opcion,
				texto: row.texto,
				activa: Boolean(row.opcion_activa),
				id_dimension: row.id_dimension,
				dimension_codigo: row.dimension_codigo,
				dimension_nombre: row.dimension_nombre,
			});
		}
	}

	return Array.from(questionMap.values());
};

module.exports = { getAllQuestionsWithOptions };
