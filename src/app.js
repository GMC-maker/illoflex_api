/**
 * Crea y configura la aplicacion Express de IlloFlex.
 * Aqui se registran middlewares y rutas, pero no se arranca el servidor.
 */
const express = require("express");
const cors = require("cors");
const indexRoutes = require("./routes/index.routes");
const testRoute = require("./routes/testRoute");
const enlaceResultadoRoute = require("./routes/enlaceResultadoRoute");

// Importa las rutas del area interna de administracion.
const adminRoute = require("./routes/adminRoute");

const app = express();

app.use(cors());
app.use(express.json());

// Ruta base de comprobacion del backend.
app.use("/", indexRoutes);

// Rutas REST del recurso test vocacional.
app.use("/api/tests", testRoute);

// Rutas REST para enlaces temporales de resultados.
app.use("/api", enlaceResultadoRoute);

// Rutas REST del area interna de administracion.
app.use("/api/admin", adminRoute);

module.exports = app;
