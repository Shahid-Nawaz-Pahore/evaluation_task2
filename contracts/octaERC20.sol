// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

 import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract OCTA_ERC20_TOKEN is ERC20 {
    constructor() ERC20("OCTA ERC20 TOKEN", "OCTA20") {
        _mint(msg.sender, 10**18);
    }
}