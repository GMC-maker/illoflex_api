/**
 * Crea y configura la aplicacion Express de IlloFlex.
 * Aqui se registran middlewares y rutas, pero no se arranca el servidor.
 */
const express = require("express");
const cors = require("cors");
const indexRoutes = require("./routes/index.routes");
const testRoute = require("./routes/testRoute");
const enlaceResultadoRoute = require("./routes/enlaceResultadoRoute");

const app = express();

app.use(cors());
app.use(express.json());

// Ruta base de comprobacion del backend.
app.use("/", indexRoutes);

// Rutas REST del recurso test vocacional.
app.use("/api/tests", testRoute);

// Rutas REST para enlaces temporales de resultados.
app.use("/api", enlaceResultadoRoute);

module.exports = app;
