const healthService = require("../services/health.service");

const getApiStatus = (req, res) => {
	const datos = healthService.getApiStatus();

	return res.status(200).json({
		ok: true,
		datos,
		mensaje: "API IlloFlex funcionando correctamente",
	});
};

module.exports = {
	getApiStatus,
};
