/**
 * Define las rutas HTTP minimas del area admin para autenticacion
 * y comprobacion del administrador autenticado.
 */

// Crea el router de Express para agrupar rutas admin.
const express = require("express");

// Importa el controller que responde al login, al endpoint /me y al logout.
const adminAuthController = require("../controllers/adminAuthController");

// Importa el controller del CRUD minimo de familias profesionales.
const adminFamiliaController = require("../controllers/adminFamiliaController");

// Importa el controller del CRUD minimo de ciclos formativos.
const adminCicloController = require("../controllers/adminCicloController");

// Importa el middleware que valida la cookie del token admin.
const authAdmin = require("../middlewares/authAdmin");

const router = express.Router();

// Permite iniciar sesion en el area interna con credenciales admin.
router.post("/login", adminAuthController.loginAdmin);

// A partir de aqui, el resto de rutas admin requieren JWT valido en cookie.
router.use(authAdmin);

// Devuelve el administrador autenticado a partir de la cookie recibida.
router.get("/me", adminAuthController.getCurrentAdmin);

// Cierra la sesion admin eliminando la cookie del token.
router.post("/logout", adminAuthController.logoutAdmin);

// Recupera todas las familias profesionales.
router.get("/familias", adminFamiliaController.getAllFamilies);

// Crea una nueva familia profesional.
router.post("/familias", adminFamiliaController.createFamily);

// Actualiza una familia profesional existente.
router.put("/familias/:idFamilia", adminFamiliaController.updateFamily);

// Recupera todos los ciclos formativos.
router.get("/ciclos", adminCicloController.getAllCiclos);

// Crea un nuevo ciclo formativo.
router.post("/ciclos", adminCicloController.createCiclo);

// Actualiza un ciclo formativo existente.
router.put("/ciclos/:idCiclo", adminCicloController.updateCiclo);

module.exports = router;
