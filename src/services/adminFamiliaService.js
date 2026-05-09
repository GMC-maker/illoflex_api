/**
 * Contiene la logica de negocio del CRUD minimo de familias
 * profesionales del area admin.
 */
const familiaRepository = require("../repositories/familiaRepository");

// Crea errores de negocio con su codigo HTTP asociado.
const createServiceError = (message, statusCode) => {
	const error = new Error(message);
	error.statusCode = statusCode;
	return error;
};

// Normaliza una familia para devolver un JSON claro y estable.
const normalizeFamilyResponse = (family) => {
	return {
		id_familia: family.id_familia,
		nombre: family.nombre,
		descripcion: family.descripcion,
	};
};

// Devuelve todas las familias profesionales.
const getAllFamilies = async () => {
	const families = await familiaRepository.getAllFamilies();

	return families.map(normalizeFamilyResponse);
};

// Valida y normaliza los datos recibidos para crear o editar una familia.
const validateFamilyData = (datosRecibidos) => {
	const nombre = datosRecibidos?.nombre?.trim();
	const descripcion = datosRecibidos?.descripcion?.trim() || null;

	if (!nombre) {
		throw createServiceError(
			"El nombre de la familia profesional es obligatorio",
			400,
		);
	}

	return {
		nombre,
		descripcion,
	};
};

// Crea una nueva familia profesional.
const createFamily = async (datosRecibidos) => {
	const familyData = validateFamilyData(datosRecibidos);
	const existingFamilies = await familiaRepository.getAllFamilies();

	const duplicatedFamily = existingFamilies.find((family) => {
		return (
			family.nombre.trim().toLowerCase() === familyData.nombre.toLowerCase()
		);
	});

	if (duplicatedFamily) {
		throw createServiceError(
			"Ya existe una familia profesional con ese nombre",
			409,
		);
	}

	const createdFamily = await familiaRepository.createFamily(familyData);

	return normalizeFamilyResponse(createdFamily);
};

// Actualiza una familia profesional existente.
const updateFamily = async (idFamilia, datosRecibidos) => {
	const familyId = Number(idFamilia);

	if (!Number.isInteger(familyId)) {
		throw createServiceError("El id de familia no es valido", 400);
	}

	const familyData = validateFamilyData(datosRecibidos);
	const existingFamily = await familiaRepository.getFamilyById(familyId);

	if (!existingFamily) {
		throw createServiceError("Familia profesional no encontrada", 404);
	}

	const existingFamilies = await familiaRepository.getAllFamilies();

	const duplicatedFamily = existingFamilies.find((family) => {
		return (
			family.id_familia !== familyId &&
			family.nombre.trim().toLowerCase() === familyData.nombre.toLowerCase()
		);
	});

	if (duplicatedFamily) {
		throw createServiceError(
			"Ya existe una familia profesional con ese nombre",
			409,
		);
	}

	const updatedFamily = await familiaRepository.updateFamily(
		existingFamily,
		familyData,
	);

	return normalizeFamilyResponse(updatedFamily);
};

module.exports = {
	getAllFamilies,
	createFamily,
	updateFamily,
};
