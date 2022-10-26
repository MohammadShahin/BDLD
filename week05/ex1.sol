// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Hash is ERC721, Ownable {
    uint256 MAX_SUPPLY = 1000;
    uint256 nftPrice = 1000000000000000;
    mapping (uint256 => string) tokensTitle;
    mapping (uint256 => string) tokensImage;

    constructor() ERC721("Hash", "HSH") {}

    function safeMint(address to, uint256 tokenId, string memory tokenTitle, string memory tokenImage)
        public
        payable
    {
        require(msg.value >= nftPrice, "The price of an NFT is alteast 0.001 ether");
        require(tokenId < MAX_SUPPLY, "Token id should be between 0 and 999 inclusive");
        _safeMint(to, tokenId);
        tokensTitle[tokenId] = tokenTitle;
        tokensImage[tokenId] = tokenImage;
    }

    function setTokenTitleAndImage(uint256 tokenId, string memory newTitle, string memory newImage) public {
        require(_isApprovedOrOwner(_msgSender(), tokenId), "ERC721: caller is not token owner or approved");
        tokensTitle[tokenId] = newTitle;
        tokensImage[tokenId] = newImage;
    }

    function getTokenInfo(uint256 tokenId) public view returns (string memory, string memory) {
        ownerOf(tokenId);
        return (tokensTitle[tokenId], tokensImage[tokenId]);
    }
}
