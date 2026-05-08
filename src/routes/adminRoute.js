/**
 * Define las rutas HTTP minimas del area admin para autenticacion
 * y comprobacion del administrador autenticado.
 */

// Crea el router de Express para agrupar rutas admin.
const express = require("express");

// Importa el controller que responde al login, al endpoint /me y al logout.
const adminAuthController = require("../controllers/adminAuthController");

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

module.exports = router;
