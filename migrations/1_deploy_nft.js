let nft = artifacts.require("CodeMavricksNFTs")

module.exports = function(deployer,network,accounts) {
    deployer.deploy(nft,{from:accounts[0]})
}