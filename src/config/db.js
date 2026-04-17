/**
 * Conexion mysql2 mantenida temporalmente mientras IlloFlex completa
 * la migracion de acceso a datos hacia Sequelize.
 */
const mysql = require("mysql2");

const connection = mysql.createConnection({
	host: process.env.DB_HOST,
	port: process.env.DB_PORT,
	user: process.env.DB_USER,
	password: process.env.DB_PASSWORD,
	database: process.env.DB_NAME,
});

connection.connect((err) => {
	if (err) {
		console.error("Error conectando a MySQL:", err);
		return;
	}
	console.log("Conectado a MySQL");
});

module.exports = connection;
