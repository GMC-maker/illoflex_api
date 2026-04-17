const healthModel = require("../models/health.model");

const getApiStatus = () => {
	return healthModel.buildApiStatus();
};

module.exports = {
	getApiStatus,
};
