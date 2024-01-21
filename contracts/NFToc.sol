// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/Base64.sol";

contract NFToc is ERC721URIStorage  {
    using Strings for uint256;
    uint256 private _tokenIds;

    mapping(uint256 => uint256) public tokenIdToLevels;

    constructor() ERC721 ("VirtualPetNFT", "PET"){
    }

    
function generatePet(uint256 tokenId) public view returns(string memory){

    bytes memory svg = abi.encodePacked(
'<svg viewBox="0 0 500 500" xmlns="http://www.w3.org/2000/svg">',
  '<rect x="-0.846" y="0.384" width="505.855" height="503.513" style="stroke: rgb(0, 0, 0); fill: rgb(240, 185, 11);" transform="matrix(1, 0, 0, 1, -5.684341886080802e-14, 0)"/>',
  '<g id="wolf" transform="matrix(0.8248270153999329, 0, 0, 0.830966055393219, 60.56135177612299, -3.8177330493927)" style="">',
    '<g>',
     ' <rect x="358" y="230" width="26" height="26" style="fill: rgb(254, 254, 254);"/>',
      '<rect x="435" y="256" width="26" height="26" style="fill: rgb(251, 251, 251);"/>',
   ' </g>',
    '<path style="fill: rgb(1, 1, 1);" d="M410,230v-25.2V179h-26v-25.4V128v-26h-26v26h-25v26h-26v25h-25v26h-26h-25.6h-25.6h-25.6h-25.6H128 v25h-26v-25.2v-25.6v-25.6V128H77v26H51v25.2v25.6v25.6V256v25.6V307h26v25.8v25.6V384v25.6v25.6V461h25v-25.8v-25.6V384v-26h26 h25.6h25.6h25.6h25.6H256v26v25.6v25.6V461h26v-25.8v-25.6V384v-26h25.2H333v-25h25.4H384v-26h25.6H435v-25.4V256v-26H410z M384,256h-26v-26h26V256z"/>',
    '<g>',
      '<polygon style="fill: rgb(43, 43, 42);" points="128,384 128,409.6 128,435.2 128,461 154,461 154,435.2 154,409.6 154,384 154,358 128,358"/>',
      '<polygon style="fill: rgb(43, 43, 42);" points="307,358 307,384 307,409.6 307,435.2 307,461 333,461 333,435.2 333,409.6 333,384 333,358"/>',
      '<text x="50%" y="10%" class="base" dominant-baseline="middle" text-anchor="middle" style="white-space: pre;">', '</text>',
    '</g>',
  '</g>',
  '<text style="white-space: pre; fill: rgb(51, 51, 51); font-family: Arial, sans-serif; font-size: 27.1px;" x="224.635" y="433.487" transform="matrix(1, 0, 0, 1, -5.684341886080802e-14, 0)">', "Pet", '</text>',
  '<text style="white-space: pre; fill: rgb(51, 51, 51); font-family: Arial, sans-serif; font-size: 27.1px;" x="175.206" y="463.533" transform="matrix(1, 0, 0, 1, -5.684341886080802e-14, 0)">', "Pet Level:", getLevels(tokenId), '</text>',
'</svg>'
    );
    return string(
        abi.encodePacked(
            "data:image/svg+xml;base64,",
            Base64.encode(svg)
        )    
    );
}  

function getLevels(uint256 tokenId) public view returns (string memory) {
    uint256 levels = tokenIdToLevels[tokenId];
    return levels.toString();
}



function getTokenURI(uint256 tokenId) public view returns (string memory){
    bytes memory dataURI = abi.encodePacked(
        '{',
            '"name": "Virtual Pet #', tokenId.toString(), '",',
            '"description": "Collectible virtual pets",',
            '"image": "', generatePet(tokenId), '"',
        '}'
    );
    return string(
        abi.encodePacked(
            "data:application/json;base64,",
            Base64.encode(dataURI)
        )
    );
}


       function mint() public {
        _tokenIds++;
        uint256 newItemId = _tokenIds;
        tokenIdToLevels[newItemId] = 0;
        _safeMint(msg.sender, newItemId);
        _setTokenURI(newItemId, getTokenURI(newItemId));
    }

    function levelUp(uint256 tokenId) public {
        require(ownerOf(tokenId) != address(0), "Please use an existing token");
        require(ownerOf(tokenId) == msg.sender, "You must own this token to train it");
        uint256 currentLevel = tokenIdToLevels[tokenId];
        tokenIdToLevels[tokenId] = currentLevel + 1;
        _setTokenURI(tokenId, getTokenURI(tokenId));
    }

}




