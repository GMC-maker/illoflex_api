/**
 * Crea y configura la aplicacion Express de IlloFlex.
 * Aqui se registran middlewares y rutas, pero no se arranca el servidor.
 */
const express = require("express");
const cors = require("cors");
const cookieParser = require("cookie-parser");
const config = require("./config/config");
const indexRoutes = require("./routes/index.routes");
const testRoute = require("./routes/testRoute");
const enlaceResultadoRoute = require("./routes/enlaceResultadoRoute");
const adminRoute = require("./routes/adminRoute");

const app = express();

// Permite peticiones desde el frontend configurado y el envio de credenciales.
app.use(
	cors({
		origin: config.frontendUrl,
		credentials: true,
	}),
);

app.use(express.json());

// Permite leer las cookies enviadas por el navegador en req.cookies.
app.use(cookieParser());

// Ruta base de comprobacion del backend.
app.use("/", indexRoutes);

// Rutas REST del recurso test vocacional.
app.use("/api/tests", testRoute);

// Rutas REST para enlaces temporales de resultados.
app.use("/api", enlaceResultadoRoute);

// Rutas REST del area interna de administracion.
app.use("/api/admin", adminRoute);

module.exports = app;
