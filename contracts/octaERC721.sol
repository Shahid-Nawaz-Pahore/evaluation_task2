// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract OCTA_ERC721_Token is ERC721{
    uint256 private _nextTokenId;
    address public owner;
    constructor() ERC721("OCTA_ERC721_Token", "OCTA721"){
        owner=msg.sender;
    }
    modifier onlyOwner{
        require(msg.sender==owner, "Only owner can call this function");
        _;
    }
    function safeMint(address to) public onlyOwner {
        uint256 tokenId = _nextTokenId++;
        _safeMint(to, tokenId);
    }
}
