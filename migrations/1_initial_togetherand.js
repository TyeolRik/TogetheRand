const TogetheRand = artifacts.require("TogetheRand");
const Simple = artifacts.require("Simple");

module.exports = function (deployer) {
  deployer.deploy(TogetheRand);
  deployer.deploy(Simple);
};
