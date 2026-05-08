/**
 * Recibe las peticiones HTTP del area admin y responde con el formato
 * JSON homogeneo del proyecto.
 */

// Importa el service que contiene la logica del login admin.
const adminAuthService = require("../services/adminAuthService");

// Gestiona el login del administrador.
const loginAdmin = async (req, res) => {
	try {
		// Delega en el service la validacion de credenciales.
		const loginResult = await adminAuthService.loginAdmin(req.body);

		return res.status(200).json({
			ok: true,
			datos: loginResult,
			mensaje: "Login admin correcto",
		});
	} catch (error) {
		return res.status(error.statusCode || 500).json({
			ok: false,
			datos: null,
			mensaje: error.message || "No se pudo iniciar sesion",
		});
	}
};

// Devuelve el administrador autenticado actual.
const getCurrentAdmin = async (req, res) => {
	try {
		// Lee el id del admin que antes habra dejado el middleware authAdmin.
		const admin = await adminAuthService.getCurrentAdmin(req.admin.id_usuario);

		return res.status(200).json({
			ok: true,
			datos: admin,
			mensaje: "Administrador autenticado recuperado correctamente",
		});
	} catch (error) {
		return res.status(error.statusCode || 500).json({
			ok: false,
			datos: null,
			mensaje: error.message || "No se pudo recuperar el administrador autenticado",
		});
	}
};

// Exporta las funciones para que pueda usarlas la ruta admin.
module.exports = {
	loginAdmin,
	getCurrentAdmin,
};
