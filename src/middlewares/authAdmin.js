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

// Extrae el JWT priorizando Authorization Bearer y manteniendo la cookie como fallback.
const getAdminTokenFromRequest = (req) => {
	const authorizationHeader = req.get("authorization") || "";

	if (authorizationHeader.startsWith("Bearer ")) {
		const bearerToken = authorizationHeader.slice("Bearer ".length).trim();

		if (bearerToken) {
			return bearerToken;
		}
	}

	// La cookie sigue soportada para localhost y futuros despliegues con HTTPS.
	return req.cookies?.[ADMIN_COOKIE_NAME];
};

// Middleware que protege rutas admin comprobando la cookie del token.
const authAdmin = (req, res, next) => {
	try {
		// Lee el token JWT priorizando Bearer y usando cookie como compatibilidad.
		const token = getAdminTokenFromRequest(req);

		// Si no existe el token en ninguna via soportada, corta la peticion con 401.
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
