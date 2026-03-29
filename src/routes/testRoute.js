/**
 * Define las rutas HTTP del recurso test.
 * En esta primera fase solo inicia un test vocacional anonimo.
 */
const express = require("express");
const testController = require("../controllers/testController");

const router = express.Router();

// Recupera un test anonimo existente a partir de su UUID.
router.get("/:uuid", testController.getTestByUuid);

// Crea un nuevo test anonimo y devuelve su UUID.
router.post("/", testController.createAnonymousTest);

module.exports = router;
