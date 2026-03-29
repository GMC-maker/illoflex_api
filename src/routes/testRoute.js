/**
 * Define las rutas HTTP del recurso test.
 * En esta primera fase solo inicia un test vocacional anonimo.
 */
const express = require("express");
const testController = require("../controllers/testController");

const router = express.Router();

// Crea un nuevo test anonimo y devuelve su UUID.
router.post("/", testController.createAnonymousTest);

module.exports = router;
