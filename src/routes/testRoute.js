/**
 * Define las rutas HTTP del recurso test.
 * En esta fase permite iniciar el test vocacional, recuperarlo por UUID
 * registrar respuestas del cuestionario y finalizarlo con resultado.
 */
const express = require("express");
const testController = require("../controllers/testController");

const router = express.Router();

// Finaliza el test, calcula el perfil y guarda el resultado vocacional.
router.post("/:uuid/finalizar", testController.finalizeTest);

// Actualiza una respuesta existente cuando el usuario vuelve atras en el test.
router.put(
	"/:uuid/respuestas/:id_respuesta",
	testController.updateTestResponse,
);

// Registra una respuesta del usuario para una pregunta del test.
router.post("/:uuid/respuestas", testController.createTestResponse);

// Recupera todas las respuestas guardadas para reconstruir el estado del test.
router.get("/:uuid/respuestas", testController.getTestResponses);

// Recupera un test anonimo existente a partir de su UUID.
router.get("/:uuid", testController.getTestByUuid);

// Crea un nuevo test anonimo y devuelve su UUID.
router.post("/", testController.createAnonymousTest);

module.exports = router;
