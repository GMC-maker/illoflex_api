const sequelize = require("../config/sequelize");
const { Pregunta, Opcion } = require("../models/respuestaModel");

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

// obtiene el resumen actual de preguntas activas, opciones activas y dimensiones
const getQuestionsSummary = async (transaction = null) => {
	const [activeQuestionRows] = await sequelize.query(
		`
			SELECT COUNT(*) AS total_preguntas_activas
			FROM pregunta
			WHERE activa = 1
		`,
		{ transaction },
	);

	const [activeOptionRows] = await sequelize.query(
		`
			SELECT COUNT(*) AS total_opciones_activas
			FROM opcion o
			INNER JOIN pregunta p ON p.id_pregunta = o.id_pregunta
			WHERE o.activa = 1
			  AND p.activa = 1
		`,
		{ transaction },
	);

	const [dimensionRows] = await sequelize.query(
		`
			SELECT
				d.codigo,
				COUNT(p.id_pregunta) AS total_opciones_activas
			FROM dimension_riasec d
			LEFT JOIN opcion o
				ON o.id_dimension = d.id_dimension
				AND o.activa = 1
			LEFT JOIN pregunta p
				ON p.id_pregunta = o.id_pregunta
				AND p.activa = 1
			GROUP BY d.id_dimension, d.codigo
			ORDER BY d.id_dimension ASC
		`,
		{ transaction },
	);

	const dimensiones = {
		R: 0,
		I: 0,
		A: 0,
		S: 0,
		E: 0,
		C: 0,
	};

	for (const row of dimensionRows) {
		dimensiones[row.codigo] = Number(row.total_opciones_activas);
	}

	return {
		preguntas_activas: Number(
			activeQuestionRows[0].total_preguntas_activas,
		),
		opciones_activas: Number(activeOptionRows[0].total_opciones_activas),
		dimensiones,
	};
};

// obtiene los codigos RIASEC de las opciones activas de una pregunta
const getPreguntaDimensionCodes = async (idPregunta, transaction = null) => {
	const [rows] = await sequelize.query(
		`
			SELECT d.codigo
			FROM opcion o
			INNER JOIN dimension_riasec d
				ON d.id_dimension = o.id_dimension
			WHERE o.id_pregunta = ?
			  AND o.activa = 1
			ORDER BY o.id_opcion ASC
		`,
		{
			replacements: [idPregunta],
			transaction,
		},
	);

	return rows.map((row) => row.codigo);
};

const getQuestionByIdWithOptions = async (idPregunta, transaction = null) => {
	return Pregunta.findOne({
		where: { id_pregunta: idPregunta },
		include: [
			{
				model: Opcion,
				as: "opciones",
				attributes: [
					"id_opcion",
					"id_pregunta",
					"id_dimension",
					"texto",
					"activa",
				],
			},
		],
		order: [[{ model: Opcion, as: "opciones" }, "id_opcion", "ASC"]],
		transaction,
	});
};

// Recibe el codigo RIASEC enviado por el formulario ("R", "I", "A", etc.)
// y lo traduce al id_dimension real guardado en base de datos.
// El "?" de la consulta se sustituye por el codigo recibido desde el formulario.
const getDimensionByCode = async (codigo, transaction = null) => {
	const [rows] = await sequelize.query(
		`
			SELECT id_dimension, codigo, nombre
			FROM dimension_riasec
			WHERE codigo = ?
			LIMIT 1
		`,
		{
			replacements: [codigo],
			transaction,
		},
	);

	return rows[0] || null;
};

const updateQuestion = async (question, { enunciado }, transaction = null) => {
	question.enunciado = enunciado;

	await question.save({ transaction });

	return question;
};

// actualiza el estado activa de la pregunta
const updatePreguntaStatus = async (question, activa, transaction = null) => {
	question.activa = activa;

	await question.save({ transaction });

	return question;
};

const updateOption = async (
	option,
	{ texto, id_dimension },
	transaction = null,
) => {
	option.texto = texto;
	option.id_dimension = id_dimension;

	await option.save({ transaction });

	return option;
};

// actualiza el estado activa de las opciones de una pregunta
const updateOpcionesStatus = async (
	idPregunta,
	activa,
	transaction = null,
) => {
	await Opcion.update(
		{ activa },
		{
			where: { id_pregunta: idPregunta },
			transaction,
		},
	);
};

module.exports = {
	getAllQuestionsWithOptions,
	getQuestionsSummary,
	getPreguntaDimensionCodes,
	getQuestionByIdWithOptions,
	getDimensionByCode,
	updateQuestion,
	updatePreguntaStatus,
	updateOption,
	updateOpcionesStatus,
};
