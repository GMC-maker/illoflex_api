/**
 * Define las rutas HTTP para crear y consultar enlaces temporales
 * de recuperacion de resultados.
 */
const express = require("express");
const enlaceResultadoController = require("../controllers/enlaceResultadoController");

const router = express.Router();

// Crea un enlace temporal para un resultado asociado a un test finalizado.
router.post("/resultados/:uuid/enlace", enlaceResultadoController.createTemporaryResultLink);

// Recupera un resultado usando el token temporal recibido por email.
router.get("/enlaces/:token", enlaceResultadoController.getResultByTemporaryToken);

module.exports = router;
