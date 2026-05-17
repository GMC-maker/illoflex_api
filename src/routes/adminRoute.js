/**
 * Son las rutas HTTP del area admin para autenticacion
 * y comprobacion del administrador autenticado.
 */
const express = require("express");
const router = express.Router();

// Importa el controller que responde al login, al endpoint /me y al logout.
const adminAuthController = require("../controllers/adminAuthController");
const adminFamiliaController = require("../controllers/adminFamiliaController");
const adminCicloController = require("../controllers/adminCicloController");
const adminPreguntaController = require("../controllers/adminPreguntaController");

// Importa el middleware que valida la cookie del token admin.
const authAdmin = require("../middlewares/authAdmin");

// Permite iniciar sesion en el area interna con credenciales admin.
router.post("/login", adminAuthController.loginAdmin);

// A partir de aqui, el resto de rutas admin requieren JWT valido en cookie.
router.use(authAdmin);

// Devuelve el administrador autenticado a partir de la cookie recibida.
router.get("/me", adminAuthController.getCurrentAdmin);

// Cierra la sesion admin eliminando la cookie del token.
router.post("/logout", adminAuthController.logoutAdmin);

// Recuperar, crear y actualizar las familias profesionales.
router.get("/familias", adminFamiliaController.getAllFamilies);
router.post("/familias", adminFamiliaController.createFamily);
router.put("/familias/:idFamilia", adminFamiliaController.updateFamily);
router.delete("/familias/:idFamilia", adminFamiliaController.deleteFamily);

// Recupera, crear y actualizar todos los ciclos formativos.
router.get("/ciclos", adminCicloController.getAllCiclos);
router.post("/ciclos", adminCicloController.createCiclo);
router.put("/ciclos/:idCiclo", adminCicloController.updateCiclo);
router.delete("/ciclos/:idCiclo", adminCicloController.deleteCiclo);

// Recupera todas las preguntas del test con sus opciones asociadas.
router.get("/preguntas", adminPreguntaController.getAllQuestions);

// Recupera el resumen del banco activo de preguntas y dimensiones RIASEC.
router.get("/preguntas/resumen", adminPreguntaController.getQuestionsSummary);

// Activa o desactiva una pregunta existente y sincroniza sus opciones asociadas.
router.patch("/preguntas/:idPregunta", adminPreguntaController.updateQuestionStatus);

// Actualiza una pregunta existente con sus opciones asociadas.
router.put("/preguntas/:idPregunta", adminPreguntaController.updateQuestion);

module.exports = router;
