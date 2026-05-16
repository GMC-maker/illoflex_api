const sequelize = require("../config/sequelize");
const adminPreguntaRepository = require("../repositories/adminPreguntaRepository");

//solo queremos obtener el listado de preguntas con sus respuestas asociadas.
const getAllQuestions = async () => {
	return adminPreguntaRepository.getAllQuestionsWithOptions();
};

const createServiceError = (message, statusCode) => {
	const error = new Error(message);
	error.statusCode = statusCode;
	return error;
};

const updateQuestion = async (idPregunta, datosRecibidos) => {
	const questionId = Number(idPregunta);

	//valida que la pregunta sea un numero
	if (!Number.isInteger(questionId)) {
		throw createServiceError("El id de pregunta no es valido", 400);
	}
	// prepara para editar la pregunta con sus opciones:
	const enunciado = datosRecibidos?.enunciado?.trim();
	const opciones = datosRecibidos?.opciones;

	if (!enunciado) {
		throw createServiceError(
			"El enunciado de la pregunta es obligatorio",
			400,
		);
	}

	if (!Array.isArray(opciones) || opciones.length !== 4) {
		throw createServiceError(
			"La pregunta debe incluir exactamente 4 opciones",
			400,
		);
	}
	// console.log("updateQuestion - datos recibidos validados:", {
	// 	questionId,
	// 	enunciado,
	// 	totalOpciones: opciones?.length,
	// });

	//recupera la pregunta con sus opciones de la bbdd
	return sequelize.transaction(async (transaction) => {
		//recupera la pregunta con sus opciones de la bbdd
		const existingQuestion =
			await adminPreguntaRepository.getQuestionByIdWithOptions(
				questionId,
				transaction,
			);

		if (!existingQuestion) {
			throw createServiceError("Pregunta no encontrada", 404);
		}

		//para guardar las nuevas opciones asociadas a la pregunta
		const opcionesPreparadas = [];

		for (const opcion of opciones) {
			const texto = opcion?.texto?.trim();
			const dimensionCodigo = opcion?.dimension_codigo?.trim();

			if (!texto) {
				throw createServiceError(
					"Todas las opciones deben tener un texto",
					400,
				);
			}

			if (!dimensionCodigo) {
				throw createServiceError(
					"Todas las opciones deben tener un codigo RIASEC",
					400,
				);
			}

			const dimension = await adminPreguntaRepository.getDimensionByCode(
				dimensionCodigo,
				transaction,
			);

			if (!dimension) {
				throw createServiceError(
					`El codigo RIASEC ${dimensionCodigo} no es valido`,
					400,
				);
			}

			//guarda las nuevas opciones-
			opcionesPreparadas.push({
				id_opcion: opcion.id_opcion,
				texto,
				id_dimension: dimension.id_dimension,
			});
		}

		// console.log("updateQuestion - opciones preparadas para guardar:", opcionesPreparadas);

		// actualiza primero la pregunta y despues las opciones asociadas updated con d
		const updatedQuestion = await adminPreguntaRepository.updateQuestion(
			existingQuestion,
			{ enunciado },
			transaction,
		);

		for (const opcionPreparada of opcionesPreparadas) {
			const existingOption = existingQuestion.opciones.find(
				(opcion) => opcion.id_opcion === opcionPreparada.id_opcion,
			);

			if (!existingOption) {
				throw createServiceError(
					`La opcion ${opcionPreparada.id_opcion} no pertenece a esta pregunta`,
					400,
				);
			}

			await adminPreguntaRepository.updateOption(
				existingOption,
				{
					texto: opcionPreparada.texto,
					id_dimension: opcionPreparada.id_dimension,
				},
				transaction,
			);
		}

		return updatedQuestion;
	});
};
//calculo o contador de tipos de preguntas:
module.exports = {
	getAllQuestions,
	updateQuestion,
};
