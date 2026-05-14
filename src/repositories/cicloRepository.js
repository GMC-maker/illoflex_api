/**
 * Centraliza el acceso a datos del recurso ciclo formativo
 * reutilizando los modelos Sequelize ya definidos en catalogoModel.
 */
const { CicloFormativo, FamiliaFp } = require("../models/catalogoModel");

// Recupera todos los ciclos formativos junto a su familia profesional.
const getAllCiclos = async () => {
	return CicloFormativo.findAll({
		include: [
			{
				model: FamiliaFp,
				as: "familia",
				attributes: ["id_familia", "nombre"],
			},
		],
		order: [
			["id_familia", "ASC"],
			["nombre", "ASC"],
		],
	});
};

// Recupera un ciclo formativo concreto por su id.
const getCicloById = async (idCiclo) => {
	return CicloFormativo.findByPk(idCiclo, {
		include: [
			{
				model: FamiliaFp,
				as: "familia",
				attributes: ["id_familia", "nombre"],
			},
		],
	});
};

// Crea un nuevo ciclo formativo en la base de datos.
const createCiclo = async ({
	id_familia,
	codigo_oficial,
	nombre,
	nivel,
	descripcion,
	duracion_horas,
}) => {
	return CicloFormativo.create({
		id_familia,
		codigo_oficial,
		nombre,
		nivel,
		descripcion,
		duracion_horas,
	});
};

// Actualiza los datos de un ciclo formativo existente.
const updateCiclo = async (
	ciclo,
	{ id_familia, codigo_oficial, nombre, nivel, descripcion, duracion_horas },
) => {
	ciclo.id_familia = id_familia;
	ciclo.codigo_oficial = codigo_oficial;
	ciclo.nombre = nombre;
	ciclo.nivel = nivel;
	ciclo.descripcion = descripcion;
	ciclo.duracion_horas = duracion_horas;

	await ciclo.save();

	return ciclo;
};

module.exports = {
	getAllCiclos,
	getCicloById,
	createCiclo,
	updateCiclo,
};
