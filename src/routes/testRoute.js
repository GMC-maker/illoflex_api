/**
 * Define las rutas HTTP del recurso test.
 * En esta fase permite iniciar el test vocacional, recuperarlo por UUID
 * y registrar respuestas del cuestionario.
 */
const express = require("express");
const testController = require("../controllers/testController");

const router = express.Router();

// Registra una respuesta del usuario para una pregunta del test.
router.post("/:uuid/respuestas", testController.createTestResponse);

// Recupera un test anonimo existente a partir de su UUID.
router.get("/:uuid", testController.getTestByUuid);

// Crea un nuevo test anonimo y devuelve su UUID.
router.post("/", testController.createAnonymousTest);

module.exports = router;
