// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract NFTMarketplace {
    address public paymentToken;
    struct Listing {
        address seller;    
        uint256 price;     
    }
    mapping(address => mapping(uint256 => Listing)) public listings;
    struct ListedNFT {
        address nftContract;
        uint256 tokenId;
        address seller;
        uint256 price;
    }
    ListedNFT[] public allListedNFTs;
    event NFTListed(address indexed nftContract, uint256 indexed tokenId, address seller, uint256 price);
    event NFTBought(address indexed nftContract, uint256 indexed tokenId, address buyer, uint256 price);
    constructor(address _paymentToken) {
        paymentToken = _paymentToken;
    }
    function listNFT(address nftContract, uint256 tokenId, uint256 price) external {
        IERC721 nft = IERC721(nftContract); 
        require(nft.ownerOf(tokenId) == msg.sender, "You must own the NFT to list it");
        nft.transferFrom(msg.sender, address(this), tokenId);
        listings[nftContract][tokenId] = Listing({
            seller: msg.sender,
            price: price
        });
        allListedNFTs.push(ListedNFT({
            nftContract: nftContract,
            tokenId: tokenId,
            seller: msg.sender,
            price: price
        }));
        emit NFTListed(nftContract, tokenId, msg.sender, price);
    }
    function buyNFT(address nftContract, uint256 tokenId) external {
        Listing memory listedItem = listings[nftContract][tokenId];
        require(listedItem.price > 0, "NFT is not listed for sale");
        IERC20 payToken = IERC20(paymentToken);
        require(payToken.transferFrom(msg.sender, listedItem.seller, listedItem.price), "Payment failed");
        IERC721(nftContract).transferFrom(address(this), msg.sender, tokenId);
        emit NFTBought(nftContract, tokenId, msg.sender, listedItem.price);
        delete listings[nftContract][tokenId];
    }
    function viewAllListedNFTs() external view returns (ListedNFT[] memory) {
        return allListedNFTs;
    }
}
