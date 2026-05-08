/**
 * Valida la cookie de administracion y deja disponible el admin
 * autenticado en req.admin para el resto del flujo.
 */

// jsonwebtoken permite verificar que el token recibido sea valido.
const jwt = require("jsonwebtoken");

// Carga la configuracion central para leer el secreto JWT.
const config = require("../config/config");

// Nombre de la cookie donde esperamos recibir el token del admin.
const ADMIN_COOKIE_NAME = "admin_token";

// Middleware que protege rutas admin comprobando la cookie del token.
const authAdmin = (req, res, next) => {
	try {
		// Lee el token JWT desde la cookie enviada por el navegador.
		const token = req.cookies?.[ADMIN_COOKIE_NAME];

		// Si no existe la cookie, corta la peticion con 401.
		if (!token) {
			return res.status(401).json({
				ok: false,
				datos: null,
				mensaje: "Token de administracion no informado",
			});
		}

		// Verifica firma y caducidad del JWT usando el secreto del backend.
		const payload = jwt.verify(token, config.adminJwt.secret);

		// Comprueba que el token realmente pertenece a un admin.
		if (payload.rol !== "ADMIN" || !payload.sub) {
			return res.status(401).json({
				ok: false,
				datos: null,
				mensaje: "Token de administracion no valido",
			});
		}

		// Guarda en req.admin los datos minimos para que los use la ruta.
		req.admin = {
			id_usuario: Number(payload.sub),
			email: payload.email,
			rol: payload.rol,
		};

		// Si todo es correcto, deja continuar a la siguiente capa.
		return next();
	} catch (error) {
		return res.status(401).json({
			ok: false,
			datos: null,
			mensaje: "Token de administracion no valido o caducado",
		});
	}
};

module.exports = authAdmin;
