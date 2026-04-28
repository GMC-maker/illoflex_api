/**
 * Contiene la logica de negocio para crear y validar enlaces temporales
 * de recuperacion del resultado de un test anonimo.
 */
const crypto = require("crypto");
const enlaceResultadoModel = require("../models/enlaceResultadoModel");
const resultadoModel = require("../models/resultadoModel");
const testModel = require("../models/testModel");
const resultadoRecomendacionRepository = require("../repositories/resultadoRecomendacionRepository");

const RESULT_LINK_EXPIRATION_DAYS = 7;

// Centraliza errores de negocio con codigo HTTP.
const createServiceError = (message, statusCode) => {
	const error = new Error(message);
	error.statusCode = statusCode;
	return error;
};

// Valida el formato minimo del correo sin guardarlo en la base de datos.
const isValidEmail = (email) => {
	const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
	return emailRegex.test(email);
};

// Genera el token real que se enviara al usuario.
const generateResultToken = () => {
	return crypto.randomBytes(32).toString("hex");
};

// Genera el hash que si se guarda en la base de datos.
const createTokenHash = (token) => {
	return crypto.createHash("sha256").update(token).digest("hex");
};

// Calcula la fecha de caducidad del enlace temporal.
const createExpirationDate = () => {
	const expirationDate = new Date();
	expirationDate.setDate(expirationDate.getDate() + RESULT_LINK_EXPIRATION_DAYS);

	return expirationDate;
};

// Normaliza las familias recomendadas para mantener una respuesta clara al frontend.
const formatRecommendedFamilies = (families) => {
	return families.map((family) => ({
		id_familia: family.id_familia,
		nombre: family.nombre,
		descripcion: family.descripcion,
		grado_afinidad: Number(family.grado_afinidad),
	}));
};

// Normaliza los ciclos recomendados incluyendo la familia profesional asociada.
const formatRecommendedCycles = (cycles) => {
	return cycles.map((cycle) => ({
		id_ciclo: cycle.id_ciclo,
		id_familia: cycle.id_familia,
		codigo_oficial: cycle.codigo_oficial,
		nombre: cycle.nombre,
		nivel: cycle.nivel,
		descripcion: cycle.descripcion,
		duracion_horas: cycle.duracion_horas,
		familia: {
			nombre: cycle.familia_nombre,
		},
		afinidad_riasec: Number(Number(cycle.afinidad_riasec).toFixed(4)),
	}));
};

// Agrupa recomendaciones para mostrar familias con sus ciclos candidatos.
const buildGroupedRecommendations = async (families, normalizedScores) => {
	const groupedRecommendations = [];

	for (const family of families.slice(0, 3)) {
		const familyCycles =
			await resultadoRecomendacionRepository.getRecommendedCyclesByFamilyAndRiasecScores(
				family.id_familia,
				normalizedScores,
				3,
			);

		groupedRecommendations.push({
			familia: {
				id_familia: family.id_familia,
				nombre: family.nombre,
				descripcion: family.descripcion,
			},
			grado_afinidad: Number(family.grado_afinidad),
			ciclos: formatRecommendedCycles(familyCycles),
		});
	}

	return groupedRecommendations;
};

// Convierte el JSON guardado del resultado en un objeto seguro para trabajar.
const getStoredScores = (storedScores) => {
	if (!storedScores) {
		return {};
	}

	if (typeof storedScores === "string") {
		return JSON.parse(storedScores);
	}

	return storedScores;
};

// Recupera un perfil completo a partir del codigo guardado en puntuaciones_json.
const getProfileResponseByCode = async (storedProfile) => {
	if (!storedProfile) {
		return null;
	}

	const profile = await resultadoModel.getProfileByCode(storedProfile.codigo);

	if (!profile) {
		return null;
	}

	return {
		id_perfil: profile.id_perfil,
		codigo: profile.codigo,
		nombre: profile.nombre,
		descripcion: profile.descripcion,
	};
};

// Construye una respuesta compatible con la pantalla actual de resultado.
const buildRecoveredResultResponse = async (resultDetails) => {
	const storedScores = getStoredScores(resultDetails.puntuaciones_json);

	const primaryProfile = {
		id_perfil: resultDetails.perfil.id_perfil,
		codigo: resultDetails.perfil.codigo,
		nombre: resultDetails.perfil.nombre,
		descripcion: resultDetails.perfil.descripcion,
	};

	const secondaryProfile = await getProfileResponseByCode(
		storedScores.perfil_secundario,
	);
	const tertiaryProfile = await getProfileResponseByCode(
		storedScores.perfil_terciario,
	);

	const recommendationProfileIds = [
		primaryProfile.id_perfil,
		secondaryProfile?.id_perfil,
		tertiaryProfile?.id_perfil,
	].filter(Boolean);

	const recommendedFamilies =
		await resultadoRecomendacionRepository.getRecommendedFamiliesByProfileIds(
			recommendationProfileIds,
			3,
		);

	const recommendedCycles =
		await resultadoRecomendacionRepository.getRecommendedCyclesByRiasecScores(
			storedScores.normalizadas,
		);

	const groupedRecommendations = await buildGroupedRecommendations(
		recommendedFamilies,
		storedScores.normalizadas,
	);

	return {
		id_resultado: resultDetails.id_resultado,
		perfil_principal: {
			codigo: primaryProfile.codigo,
			nombre: primaryProfile.nombre,
			descripcion: primaryProfile.descripcion,
		},
		perfil_secundario: secondaryProfile
			? {
					codigo: secondaryProfile.codigo,
					nombre: secondaryProfile.nombre,
					descripcion: secondaryProfile.descripcion,
				}
			: null,
		perfil_terciario: tertiaryProfile
			? {
					codigo: tertiaryProfile.codigo,
					nombre: tertiaryProfile.nombre,
					descripcion: tertiaryProfile.descripcion,
				}
			: null,
		puntuaciones: {
			brutas: storedScores.brutas,
			normalizadas: storedScores.normalizadas,
		},
		recomendaciones: groupedRecommendations,
		familias_recomendadas: formatRecommendedFamilies(recommendedFamilies),
		ciclos_recomendados: formatRecommendedCycles(recommendedCycles),
	};
};

// Crea un enlace temporal para recuperar el resultado asociandolo a un unico correo.
const createTemporaryResultLink = async (uuid, email) => {
	if (!email || !isValidEmail(email)) {
		throw createServiceError("El correo electronico no tiene un formato valido", 400);
	}

	const vocationalTest = await testModel.getTestByUuid(uuid);

	if (!vocationalTest) {
		throw createServiceError("Test no encontrado", 404);
	}

	if (vocationalTest.estado !== "FINALIZADO") {
		throw createServiceError("El test debe estar finalizado para generar el enlace", 409);
	}

	const result = await resultadoModel.getResultByTestId(vocationalTest.id_test);

	if (!result) {
		throw createServiceError("El test no tiene resultado generado", 404);
	}

	const activeResultLink = await enlaceResultadoModel.getActiveResultLinkByTestId(
		vocationalTest.id_test,
	);

	if (activeResultLink) {
		if (activeResultLink.email && activeResultLink.email !== email) {
			throw createServiceError(
				"Este test ya tiene un enlace temporal asociado a otro correo",
				409,
			);
		}

		// Reutiliza el mismo enlace vigente para no crear tokens distintos del mismo test.
		if (activeResultLink.token) {
			return {
				token: activeResultLink.token,
				expira_en: activeResultLink.expira_en,
				dias_validez: RESULT_LINK_EXPIRATION_DAYS,
				reutilizado: true,
			};
		}
	}

	const token = generateResultToken();
	const tokenHash = createTokenHash(token);
	const expirationDate = createExpirationDate();

	if (activeResultLink) {
		await enlaceResultadoModel.updateResultLink(activeResultLink, {
			email,
			token,
			tokenHash,
			expirationDate: activeResultLink.expira_en,
		});
	} else {
		await enlaceResultadoModel.createResultLink({
			idTest: vocationalTest.id_test,
			email,
			token,
			tokenHash,
			expirationDate,
		});
	}

	return {
		token,
		expira_en: activeResultLink ? activeResultLink.expira_en : expirationDate,
		dias_validez: RESULT_LINK_EXPIRATION_DAYS,
	};
};

// Recupera el resultado asociado a un token temporal valido.
const getResultByTemporaryToken = async (token) => {
	if (!token) {
		throw createServiceError("Token no informado", 400);
	}

	const tokenHash = createTokenHash(token);
	const resultLink = await enlaceResultadoModel.getResultLinkByTokenHash(tokenHash);

	if (!resultLink) {
		throw createServiceError("Enlace no encontrado", 404);
	}

	if (new Date(resultLink.expira_en) < new Date()) {
		throw createServiceError("El enlace temporal ha caducado", 410);
	}

	await enlaceResultadoModel.markResultLinkAsUsed(resultLink);

	const resultDetails = await resultadoModel.getResultDetailsByTestId(
		resultLink.id_test,
	);

	if (!resultDetails) {
		throw createServiceError("Resultado no encontrado", 404);
	}

	return buildRecoveredResultResponse(resultDetails);
};

module.exports = {
	createTemporaryResultLink,
	getResultByTemporaryToken,
};
