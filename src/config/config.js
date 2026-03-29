/**
 * Centraliza la carga de variables de entorno y expone la configuracion
 * general de IlloFlex para que el resto de capas no lean process.env
 * directamente.
 */
const path = require("path");
const dotenv = require("dotenv");

const environment = process.env.NODE_ENV || "development";
const envFilePath = path.resolve(__dirname, `../../.env.${environment}`);

// Carga el fichero .env correspondiente al entorno activo.
dotenv.config({ path: envFilePath });

module.exports = {
	environment,
	port: process.env.PORT || 3000,
	db: {
		host: process.env.DB_HOST || "localhost",
		port: Number(process.env.DB_PORT) || 3306,
		user: process.env.DB_USER || "root",
		password: process.env.DB_PASSWORD || "",
		name: process.env.DB_NAME || "illoflex",
	},
};
