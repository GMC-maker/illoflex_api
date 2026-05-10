/**
 * Contiene la logica de negocio del CRUD minimo de ciclos
 * formativos del area admin.
 */
const cicloRepository = require("../repositories/cicloRepository");
const familiaRepository = require("../repositories/familiaRepository");

// Crea errores de negocio con su codigo HTTP asociado.
const createServiceError = (message, statusCode) => {
	const error = new Error(message);
	error.statusCode = statusCode;
	return error;
};

// Normaliza un ciclo para devolver un JSON claro y estable.
const normalizeCicloResponse = (ciclo) => {
	return {
		id_ciclo: ciclo.id_ciclo,
		id_familia: ciclo.id_familia,
		codigo_oficial: ciclo.codigo_oficial,
		nombre: ciclo.nombre,
		nivel: ciclo.nivel,
		descripcion: ciclo.descripcion,
		duracion_horas: ciclo.duracion_horas,
		familia: ciclo.familia
			? {
					id_familia: ciclo.familia.id_familia,
					nombre: ciclo.familia.nombre,
				}
			: null,
	};
};

// Devuelve todos los ciclos formativos.
const getAllCiclos = async () => {
	const ciclos = await cicloRepository.getAllCiclos();

	return ciclos.map(normalizeCicloResponse);
};

// Valida y normaliza los datos recibidos para crear o editar un ciclo.
const validateCicloData = (datosRecibidos) => {
	const idFamilia = Number(datosRecibidos?.id_familia);
	const codigoOficial = datosRecibidos?.codigo_oficial?.trim() || null;
	const nombre = datosRecibidos?.nombre?.trim();
	const nivel = datosRecibidos?.nivel?.trim();
	const descripcion = datosRecibidos?.descripcion?.trim() || null;

	let duracionHoras = null;

	if (!Number.isInteger(idFamilia)) {
		throw createServiceError("El id de familia no es valido", 400);
	}

	if (!nombre) {
		throw createServiceError("El nombre del ciclo formativo es obligatorio", 400);
	}

	if (!nivel) {
		throw createServiceError("El nivel del ciclo formativo es obligatorio", 400);
	}

	if (
		datosRecibidos?.duracion_horas !== undefined &&
		datosRecibidos?.duracion_horas !== null &&
		datosRecibidos?.duracion_horas !== ""
	) {
		duracionHoras = Number(datosRecibidos.duracion_horas);

		if (!Number.isInteger(duracionHoras) || duracionHoras <= 0) {
			throw createServiceError(
				"La duracion en horas debe ser un numero entero positivo",
				400,
			);
		}
	}

	return {
		id_familia: idFamilia,
		codigo_oficial: codigoOficial,
		nombre,
		nivel,
		descripcion,
		duracion_horas: duracionHoras,
	};
};

// Comprueba que la familia profesional indicada exista.
const ensureFamiliaExists = async (idFamilia) => {
	const familia = await familiaRepository.getFamilyById(idFamilia);

	if (!familia) {
		throw createServiceError("Familia profesional no encontrada", 404);
	}
};

// Busca duplicados simples para no crear ciclos repetidos.
const findDuplicatedCiclo = (ciclos, cicloData, idCicloActual = null) => {
	return ciclos.find((ciclo) => {
		if (idCicloActual !== null && ciclo.id_ciclo === idCicloActual) {
			return false;
		}

		const sameCodigoOficial =
			cicloData.codigo_oficial &&
			ciclo.codigo_oficial &&
			ciclo.codigo_oficial.trim().toLowerCase() ===
				cicloData.codigo_oficial.toLowerCase();

		const sameNombreInFamilia =
			ciclo.id_familia === cicloData.id_familia &&
			ciclo.nombre.trim().toLowerCase() === cicloData.nombre.toLowerCase();

		return sameCodigoOficial || sameNombreInFamilia;
	});
};

// Crea un nuevo ciclo formativo.
const createCiclo = async (datosRecibidos) => {
	const cicloData = validateCicloData(datosRecibidos);

	await ensureFamiliaExists(cicloData.id_familia);

	const existingCiclos = await cicloRepository.getAllCiclos();
	const duplicatedCiclo = findDuplicatedCiclo(existingCiclos, cicloData);

	if (duplicatedCiclo) {
		if (
			cicloData.codigo_oficial &&
			duplicatedCiclo.codigo_oficial &&
			duplicatedCiclo.codigo_oficial.trim().toLowerCase() ===
				cicloData.codigo_oficial.toLowerCase()
		) {
			throw createServiceError(
				"Ya existe un ciclo formativo con ese codigo oficial",
				409,
			);
		}

		throw createServiceError(
			"Ya existe un ciclo formativo con ese nombre en la familia profesional seleccionada",
			409,
		);
	}

	const createdCiclo = await cicloRepository.createCiclo(cicloData);
	const savedCiclo = await cicloRepository.getCicloById(createdCiclo.id_ciclo);

	return normalizeCicloResponse(savedCiclo);
};

// Actualiza un ciclo formativo existente.
const updateCiclo = async (idCiclo, datosRecibidos) => {
	const cicloId = Number(idCiclo);

	if (!Number.isInteger(cicloId)) {
		throw createServiceError("El id de ciclo no es valido", 400);
	}

	const cicloData = validateCicloData(datosRecibidos);
	const existingCiclo = await cicloRepository.getCicloById(cicloId);

	if (!existingCiclo) {
		throw createServiceError("Ciclo formativo no encontrado", 404);
	}

	await ensureFamiliaExists(cicloData.id_familia);

	const existingCiclos = await cicloRepository.getAllCiclos();
	const duplicatedCiclo = findDuplicatedCiclo(
		existingCiclos,
		cicloData,
		cicloId,
	);

	if (duplicatedCiclo) {
		if (
			cicloData.codigo_oficial &&
			duplicatedCiclo.codigo_oficial &&
			duplicatedCiclo.codigo_oficial.trim().toLowerCase() ===
				cicloData.codigo_oficial.toLowerCase()
		) {
			throw createServiceError(
				"Ya existe un ciclo formativo con ese codigo oficial",
				409,
			);
		}

		throw createServiceError(
			"Ya existe un ciclo formativo con ese nombre en la familia profesional seleccionada",
			409,
		);
	}

	await cicloRepository.updateCiclo(existingCiclo, cicloData);

	const updatedCiclo = await cicloRepository.getCicloById(cicloId);

	return normalizeCicloResponse(updatedCiclo);
};

module.exports = {
	getAllCiclos,
	createCiclo,
	updateCiclo,
};
