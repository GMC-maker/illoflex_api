/**
 * Arranca el servidor HTTP y valida primero la conexion principal a la base
 * de datos para no aceptar peticiones si la infraestructura no esta lista.
 */
const app = require("./app");
const config = require("./config/config");
const sequelize = require("./config/sequelize");

const startServer = async () => {
	try {
		// Verifica la conexion ORM antes de levantar la API.
		await sequelize.authenticate();
		console.log("Conexion Sequelize a MySQL establecida correctamente");

		app.listen(config.port, () => {
			console.log(`Servidor corriendo en http://localhost:${config.port}`);
		});
	} catch (error) {
		console.error("No se pudo conectar con la base de datos:", error.message);
		process.exit(1);
	}
};

startServer();
