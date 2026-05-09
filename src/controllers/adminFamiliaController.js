/**
 * Recibe las peticiones HTTP del CRUD minimo de familias
 * profesionales del area admin.
 */
const adminFamiliaService = require("../services/adminFamiliaService");

// Devuelve todas las familias profesionales.
const getAllFamilies = async (req, res) => {
	try {
		const families = await adminFamiliaService.getAllFamilies();

		return res.status(200).json({
			ok: true,
			datos: families,
			mensaje: "Familias profesionales recuperadas correctamente",
		});
	} catch (error) {
		return res.status(error.statusCode || 500).json({
			ok: false,
			datos: null,
			mensaje:
				error.message ||
				"No se pudieron recuperar las familias profesionales",
		});
	}
};

// Crea una nueva familia profesional.
const createFamily = async (req, res) => {
	try {
		const createdFamily = await adminFamiliaService.createFamily(req.body);

		return res.status(201).json({
			ok: true,
			datos: createdFamily,
			mensaje: "Familia profesional creada correctamente",
		});
	} catch (error) {
		return res.status(error.statusCode || 500).json({
			ok: false,
			datos: null,
			mensaje: error.message || "No se pudo crear la familia profesional",
		});
	}
};

// Actualiza una familia profesional existente.
const updateFamily = async (req, res) => {
	try {
		const updatedFamily = await adminFamiliaService.updateFamily(
			req.params.idFamilia,
			req.body,
		);

		return res.status(200).json({
			ok: true,
			datos: updatedFamily,
			mensaje: "Familia profesional actualizada correctamente",
		});
	} catch (error) {
		return res.status(error.statusCode || 500).json({
			ok: false,
			datos: null,
			mensaje:
				error.message || "No se pudo actualizar la familia profesional",
		});
	}
};

module.exports = {
	getAllFamilies,
	createFamily,
	updateFamily,
};
