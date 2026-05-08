/**
 * Contiene la logica de negocio de autenticacion del area admin.
 * Valida credenciales y recupera el admin autenticado.
 */

// bcrypt compara la password en texto plano con el hash guardado en BD.
const bcrypt = require("bcrypt");

// jsonwebtoken genera el token JWT cuando el login es correcto.
const jwt = require("jsonwebtoken");

// Carga la configuracion central, incluido el secreto JWT.
const config = require("../config/config");

// Permite consultar la tabla usuario buscando solo admins.
const usuarioModel = require("../models/usuarioModel");

// Crea errores de negocio con su codigo HTTP asociado.
const createServiceError = (message, statusCode) => {
	const error = new Error(message);
	error.statusCode = statusCode;
	return error;
};

// Devuelve solo los datos del admin que si queremos exponer en la API.
const normalizeAdminResponse = (admin) => {
	return {
		id_usuario: admin.id_usuario,
		email: admin.email,
		rol: admin.rol,
		fecha_registro: admin.fecha_registro,
	};
};

// Genera el JWT del admin autenticado con id, email y rol.
const createAdminToken = (admin) => {
	return jwt.sign(
		{
			sub: String(admin.id_usuario),
			email: admin.email,
			rol: admin.rol,
		},
		config.adminJwt.secret,
		{
			expiresIn: config.adminJwt.expiresIn,
		},
	);
};

// Valida el login admin y, si todo es correcto, devuelve token + admin.
const loginAdmin = async (credentials) => {
	const email = credentials?.email?.trim()?.toLowerCase();
	const password = credentials?.password;

	if (!email || !password) {
		throw createServiceError("Debes indicar email y password", 400);
	}

	const admin = await usuarioModel.getAdminByEmail(email);

	if (!admin || !admin.password_hash) {
		throw createServiceError("Credenciales invalidas", 401);
	}

	const passwordIsValid = await bcrypt.compare(password, admin.password_hash);

	if (!passwordIsValid) {
		throw createServiceError("Credenciales invalidas", 401);
	}

	return {
		token: createAdminToken(admin),
		admin: normalizeAdminResponse(admin),
	};
};

// Recupera el admin autenticado a partir de su id.
const getCurrentAdmin = async (idUsuario) => {
	if (!Number.isInteger(Number(idUsuario))) {
		throw createServiceError("Administrador no valido", 401);
	}

	const admin = await usuarioModel.getAdminById(Number(idUsuario));

	if (!admin) {
		throw createServiceError("Administrador no autenticado", 401);
	}

	return normalizeAdminResponse(admin);
};

// Exporta las funciones del service para que las use el controller.
module.exports = {
	loginAdmin,
	getCurrentAdmin,
};
