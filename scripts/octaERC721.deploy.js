const hre = require("hardhat");
async function main() {
  const currentTimestampInSeconds = Math.round(Date.now() / 1000);
  const unlockTime = currentTimestampInSeconds + 60;
  const lockedAmount = hre.ethers.utils.parseEther("0.001");
  const OCTA_ERC721_Token = await hre.ethers.deployContract(
    "OCTA_ERC721_Token"
  );
  await OCTA_ERC721_Token.deployed();
  console.log(
    `OCTA ERC720 Token smart  contract with ${hre.ethers.utils.formatEther(
      lockedAmount
    )} ETH and  timestamp ${unlockTime} is deployed to ${
      OCTA_ERC721_Token.address
    }`
  );
  console.log("verification process...");

  await run("verify:verify", {
    address: OCTA_ERC721_Token.address,
    contract: "contracts/octaERC721.sol:OCTA_ERC721_Token",
    constructorArguments: [],
  });
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
