/**
 * Centraliza la carga de variables de entorno y expone la configuracion
 * general de IlloFlex para que el resto de capas no lean process.env
 * directamente. En este proyecto todas las variables obligatorias deben
 * venir definidas desde el entorno para evitar configuraciones sensibles
 * hardcodeadas en un repositorio publico.
 */
const path = require("path");
const dotenv = require("dotenv");

const environment = process.env.NODE_ENV || "development";
const envFilePath = path.resolve(__dirname, `../../.env.${environment}`);

// Carga el fichero .env correspondiente al entorno activo.
dotenv.config({ path: envFilePath });

const requiredEnvVars = [
	"PORT",
	"DB_HOST",
	"DB_PORT",
	"DB_USER",
	"DB_PASSWORD",
	"DB_NAME",
];

// Valida que la aplicacion no arranque con configuracion incompleta.
requiredEnvVars.forEach((envVarName) => {
	if (!process.env[envVarName]) {
		throw new Error(`Falta la variable de entorno obligatoria: ${envVarName}`);
	}
});

module.exports = {
	environment,
	port: Number(process.env.PORT),
	db: {
		host: process.env.DB_HOST,
		port: Number(process.env.DB_PORT),
		user: process.env.DB_USER,
		password: process.env.DB_PASSWORD,
		name: process.env.DB_NAME,
	},
};
