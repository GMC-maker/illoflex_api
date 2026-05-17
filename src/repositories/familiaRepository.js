/**
 * Centraliza el acceso a datos del recurso familia profesional
 * reutilizando el modelo Sequelize ya definido en catalogoModel.
 */
const { FamiliaFp } = require("../models/catalogoModel");

// Recupera todas las familias profesionales ordenadas por nombre.
const getAllFamilies = async () => {
	return FamiliaFp.findAll({
		order: [["nombre", "ASC"]],
	});
};

// Recupera una familia profesional concreta por su id.
const getFamilyById = async (idFamilia) => {
	return FamiliaFp.findByPk(idFamilia);
};

// Crea una nueva familia profesional en la base de datos.
const createFamily = async ({ nombre, descripcion }) => {
	return FamiliaFp.create({
		nombre,
		descripcion,
	});
};

// Actualiza los datos de una familia profesional existente.
const updateFamily = async (family, { nombre, descripcion }) => {
	family.nombre = nombre;
	family.descripcion = descripcion;

	await family.save();

	return family;
};

// Elimina una familia profesional existente.
const deleteFamily = async (family) => {
	await family.destroy();
};

module.exports = {
	getAllFamilies,
	getFamilyById,
	createFamily,
	updateFamily,
	deleteFamily,
};
