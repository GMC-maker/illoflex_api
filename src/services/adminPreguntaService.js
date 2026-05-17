const sequelize = require("../config/sequelize");
const adminPreguntaRepository = require("../repositories/adminPreguntaRepository");

//solo queremos obtener el listado de preguntas con sus respuestas asociadas.
const getAllQuestions = async () => {
	return adminPreguntaRepository.getAllQuestionsWithOptions();
};

const getQuestionsSummary = async () => {
	return adminPreguntaRepository.getQuestionsSummary();
};

const createServiceError = (message, statusCode) => {
	const error = new Error(message);
	error.statusCode = statusCode;
	return error;
};

// valida que idPregunta sea un numero valido y que activa sea boolean
// prepara para convertir idPregunta a numero
// devuelve ambos valores listos para usarlos despues
const verifyPreguntaStatus = (idPregunta, datosRecibidos) => {
	const preguntaId = Number(idPregunta);
	const activa = datosRecibidos?.activa;

	if (!Number.isInteger(preguntaId)) {
		throw createServiceError("El id de pregunta no es valido", 400);
	}

	if (typeof activa !== "boolean") {
		throw createServiceError(
			"Debes indicar si la pregunta queda activa o inactiva",
			400,
		);
	}

	return {
		preguntaId,
		activa,
	};
};

// valida que existan 15 preguntas activas como minimo
const verifyMinPreguntas = (summary) => {
	if (summary.preguntas_activas <= 15) {
		throw createServiceError(
			"No se puede inactivar la pregunta porque deben quedar al menos 15 preguntas activas",
			409,
		);
	}
};

// valida que al inactivar la pregunta ninguna dimension quede vacia
const verifyPreguntaDimension = (summary, dimensionCodes) => {
	const dimensionesRestantes = { ...summary.dimensiones };

	for (const codigo of dimensionCodes) {
		const totalActual = Number(dimensionesRestantes[codigo] || 0);
		dimensionesRestantes[codigo] = totalActual - 1;
	}

	const dimensionVacia = Object.entries(dimensionesRestantes).find(
		([, total]) => total <= 0,
	);

	if (dimensionVacia) {
		throw createServiceError(
			`La dimension ${dimensionVacia[0]} no puede quedar vacia. Debe quedar al menos 1 opcion activa`,
			409,
		);
	}
};

// valida que las opciones de la pregunta sigan activas antes de inactivarlas
const verifyActiveOptions = (pregunta) => {
	const hasInactiveOption = pregunta.opciones.some(
		(opcion) => !Boolean(opcion.activa),
	);

	if (hasInactiveOption) {
		throw createServiceError(
			"No se puede inactivar la pregunta porque tiene opciones ya inactivas",
			409,
		);
	}
};

// devuelve los datos minimos del estado actual de la pregunta
const getPreguntaStatusData = (pregunta) => {
	return {
		id_pregunta: pregunta.id_pregunta,
		enunciado: pregunta.enunciado,
		orden: pregunta.orden,
		activa: Boolean(pregunta.activa),
	};
};

// cambia el estado de la pregunta y de sus opciones en una misma transaccion
const updateQuestionStatus = async (idPregunta, datosRecibidos) => {
	const { preguntaId, activa } = verifyPreguntaStatus(
		idPregunta,
		datosRecibidos,
	);

	return sequelize.transaction(async (transaction) => {
		const preguntaExistente =
			await adminPreguntaRepository.getQuestionByIdWithOptions(
				preguntaId,
				transaction,
			);

		if (!preguntaExistente) {
			throw createServiceError("Pregunta no encontrada", 404);
		}

		if (Boolean(preguntaExistente.activa) === activa) {
			return getPreguntaStatusData(preguntaExistente);
		}

		if (!activa) {
			const summary =
				await adminPreguntaRepository.getQuestionsSummary(transaction);
			const dimensionCodes =
				await adminPreguntaRepository.getPreguntaDimensionCodes(
					preguntaId,
					transaction,
				);

			verifyMinPreguntas(summary);
			verifyActiveOptions(preguntaExistente);
			verifyPreguntaDimension(summary, dimensionCodes);

			// primero se inactivan las opciones y despues la pregunta
			await adminPreguntaRepository.updateOpcionesStatus(
				preguntaId,
				false,
				transaction,
			);

			await adminPreguntaRepository.updatePreguntaStatus(
				preguntaExistente,
				false,
				transaction,
			);
		} else {
			await adminPreguntaRepository.updatePreguntaStatus(
				preguntaExistente,
				true,
				transaction,
			);

			// al reactivar se recuperan juntos la pregunta y sus opciones
			await adminPreguntaRepository.updateOpcionesStatus(
				preguntaId,
				true,
				transaction,
			);
		}

		const preguntaActualizada =
			await adminPreguntaRepository.getQuestionByIdWithOptions(
				preguntaId,
				transaction,
			);

		return getPreguntaStatusData(preguntaActualizada);
	});
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
	getQuestionsSummary,
	updateQuestionStatus,
	updateQuestion,
};
