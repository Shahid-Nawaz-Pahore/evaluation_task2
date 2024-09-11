const hre = require("hardhat");
async function main() {
  const currentTimestampInSeconds = Math.round(Date.now() / 1000);
  const unlockTime = currentTimestampInSeconds + 60;
  const lockedAmount = hre.ethers.utils.parseEther("0.001");
  const OCTA_ERC20_TOKEN = await hre.ethers.deployContract("OCTA_ERC20_TOKEN");
  await OCTA_ERC20_TOKEN.deployed();
  console.log(
    `OCTA ERC20 Token smart  contract with ${hre.ethers.utils.formatEther(
      lockedAmount
    )} ETH and  timestamp ${unlockTime} is deployed to ${
      OCTA_ERC20_TOKEN.address
    }`
  );
  console.log("verification process...");

  await run("verify:verify", {
    address: OCTA_ERC20_TOKEN.address,
    contract: "contracts/octaERC20.sol:OCTA_ERC20_TOKEN",
    constructorArguments: [],
  });
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
