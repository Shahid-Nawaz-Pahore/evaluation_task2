const hre = require("hardhat");

async function main() {
  const currentTimestampInSeconds = Math.round(Date.now() / 1000);
  const unlockTime = currentTimestampInSeconds + 60;
  const lockedAmount = hre.ethers.utils.parseEther("0.001");
  const paymentTokenAddress = "0x2880b2025c109624ac84e245214792be4f36b446";
  const NFTMarketplace = await hre.ethers.deployContract("NFTMarketplace", [
    paymentTokenAddress,
  ]);
  await NFTMarketplace.deployed();
  console.log(
    `NFT Marketplace smart contract deployed at ${NFTMarketplace.address} with payment token address ${paymentTokenAddress}`
  );
  console.log("Verification process...");
  await hre.run("verify:verify", {
    address: NFTMarketplace.address,
    contract: "contracts/nftMarketplace.sol:NFTMarketplace",
    constructorArguments: [paymentTokenAddress],
  });
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
