/**
 * Contiene la logica de negocio del recurso test.
 * Aqui se generan los datos necesarios antes de persistirlos.
 */
const { v4: uuidv4 } = require("uuid");
const testModel = require("../models/testModel");

const createAnonymousTest = async () => {
	// Cada intento del test se identifica con un UUID unico y anonimo.
	const uuid = uuidv4();

	const createdTest = await testModel.createAnonymousTest(uuid);

	return {
		uuid: createdTest.uuid,
		estado: createdTest.estado,
	};
};

module.exports = {
	createAnonymousTest,
};
