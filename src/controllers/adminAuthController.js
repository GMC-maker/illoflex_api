/**
 * Recibe las peticiones HTTP del area admin y responde con el formato
 * JSON homogeneo del proyecto.
 */

// Importa la configuracion para reutilizar el tiempo de expiracion del token.
const config = require("../config/config");

// Importa el service que contiene la logica del login admin.
const adminAuthService = require("../services/adminAuthService");

// Nombre fijo de la cookie donde guardaremos el JWT del admin.
const ADMIN_COOKIE_NAME = "admin_token";

// Convierte valores tipo "1h" o "30m" a milisegundos para maxAge de la cookie.
const getCookieMaxAge = (expiresIn) => {
	const timeUnitsToMs = {
		m: 60 * 1000,
		h: 60 * 60 * 1000,
		d: 24 * 60 * 60 * 1000,
	};

	const match = String(expiresIn).match(/^(\d+)([mhd])$/);

	if (!match) {
		// Si no coincide con el formato esperado, usa 1 hora por defecto.
		return 60 * 60 * 1000;
	}

	const value = Number(match[1]);
	const unit = match[2];

	return value * timeUnitsToMs[unit];
};

// Construye la configuracion segura de la cookie del admin.
const buildAdminCookieOptions = () => {
	return {
		httpOnly: true,
		secure: config.environment === "production",
		sameSite: config.environment === "production" ? "strict" : "lax",
		maxAge: getCookieMaxAge(config.adminJwt.expiresIn),
	};
};

// Gestiona el login del administrador.
const loginAdmin = async (req, res) => {
	try {
		// Delega en el service la validacion de credenciales.
		const loginResult = await adminAuthService.loginAdmin(req.body);

		// Guarda el JWT en una cookie para que el navegador lo reenvie automaticamente.
		res.cookie(
			ADMIN_COOKIE_NAME,
			loginResult.token,
			buildAdminCookieOptions(),
		);

		// No hace falta devolver el token al frontend porque ya va en cookie.
		return res.status(200).json({
			ok: true,
			datos: {
				admin: loginResult.admin,
			},
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
		const admin = await adminAuthService.getCurrentAdmin(
			req.admin.id_usuario,
		);

		return res.status(200).json({
			ok: true,
			datos: admin,
			mensaje: "Administrador autenticado recuperado correctamente",
		});
	} catch (error) {
		return res.status(error.statusCode || 500).json({
			ok: false,
			datos: null,
			mensaje:
				error.message ||
				"No se pudo recuperar el administrador autenticado",
		});
	}
};

// Cierra la sesion admin eliminando la cookie del token.
const logoutAdmin = async (req, res) => {
	try {
		// Borra la cookie del navegador para invalidar la sesion desde cliente.
		res.clearCookie(ADMIN_COOKIE_NAME, buildAdminCookieOptions());

		return res.status(200).json({
			ok: true,
			datos: null,
			mensaje: "Logout admin correcto",
		});
	} catch (error) {
		return res.status(500).json({
			ok: false,
			datos: null,
			mensaje: "No se pudo cerrar la sesion admin",
		});
	}
};

// Exporta las funciones para que pueda usarlas la ruta admin.
module.exports = {
	loginAdmin,
	getCurrentAdmin,
	logoutAdmin,
};
