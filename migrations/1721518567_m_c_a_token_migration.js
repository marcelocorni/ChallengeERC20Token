const MCAToken = artifacts.require("MCAToken");

module.exports = function (deployer) {
    const initialSupply = web3.utils.toWei('150', 'ether'); // 150 tokens with 18 decimals
    deployer.deploy(MCAToken, initialSupply);
};