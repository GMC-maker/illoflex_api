/**
 * Recibe las peticiones HTTP del CRUD minimo de ciclos
 * formativos del area admin.
 */
const adminCicloService = require("../services/adminCicloService");

// Devuelve todos los ciclos formativos.
const getAllCiclos = async (req, res) => {
	try {
		const ciclos = await adminCicloService.getAllCiclos();

		return res.status(200).json({
			ok: true,
			datos: ciclos,
			mensaje: "Ciclos formativos recuperados correctamente",
		});
	} catch (error) {
		return res.status(error.statusCode || 500).json({
			ok: false,
			datos: null,
			mensaje:
				error.message ||
				"No se pudieron recuperar los ciclos formativos",
		});
	}
};

// Crea un nuevo ciclo formativo.
const createCiclo = async (req, res) => {
	try {
		const createdCiclo = await adminCicloService.createCiclo(req.body);

		return res.status(201).json({
			ok: true,
			datos: createdCiclo,
			mensaje: "Ciclo formativo creado correctamente",
		});
	} catch (error) {
		return res.status(error.statusCode || 500).json({
			ok: false,
			datos: null,
			mensaje: error.message || "No se pudo crear el ciclo formativo",
		});
	}
};

// Actualiza un ciclo formativo existente.
const updateCiclo = async (req, res) => {
	try {
		const updatedCiclo = await adminCicloService.updateCiclo(
			req.params.idCiclo,
			req.body,
		);

		return res.status(200).json({
			ok: true,
			datos: updatedCiclo,
			mensaje: "Ciclo formativo actualizado correctamente",
		});
	} catch (error) {
		return res.status(error.statusCode || 500).json({
			ok: false,
			datos: null,
			mensaje:
				error.message || "No se pudo actualizar el ciclo formativo",
		});
	}
};
// Elimina un ciclo formativo existente.
const deleteCiclo = async (req, res) => {
	try {
		await adminCicloService.deleteCiclo(req.params.idCiclo);

		return res.status(200).json({
			ok: true,
			datos: null,
			mensaje: "Ciclo formativo eliminado correctamente",
		});
	} catch (error) {
		return res.status(error.statusCode || 500).json({
			ok: false,
			datos: null,
			mensaje: error.message || "No se pudo eliminar el ciclo formativo",
		});
	}
};

module.exports = {
	getAllCiclos,
	createCiclo,
	updateCiclo,
	deleteCiclo,
};
