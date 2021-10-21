const hre = require("hardhat");
const { ethers } = hre;

main = async () => {
    [deployer] = await ethers.getSigners();
    console.log("Deployer address = ", deployer.address);

    const NFT = await ethers.getContractFactory("NFT");
    const nft = await NFT.deploy("Simple NFT", "sNFT", "", "");
    await nft.deployed();
    console.log("NFT deployed at", nft.address);
};

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });