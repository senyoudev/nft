// SPDX-License-Identifier: MIT



pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract CodeMavricksNFTs is ERC721 {
     using Counters for Counters.Counter;
    Counters.Counter private _tokenIdCounter;

    mapping(uint256 => address) tokenOwner;
    mapping(uint256 => bool) tokenExists;

    constructor() ERC721("leprogrammermarocain", "pgmar") {}

  function _baseURI() internal pure override returns (string memory) {
        return "https://gateway.pinata.cloud/ipfs/QmZeSmVsWZEdbK89pu56JBcc1REzrdc5sKGqPC55yqW56d";
    }

    function mint(address to)
        public returns (uint256)
    {
        _tokenIdCounter.increment();
        tokenOwner[_tokenIdCounter.current()] = to;
        tokenExists[_tokenIdCounter.current()] = true;
        _safeMint(to, _tokenIdCounter.current());

        return _tokenIdCounter.current();
    }

    function ownerOf(uint256 _tokenId) public view override returns(address) {
      require(tokenExists[_tokenId],"token does not exist");
      return tokenOwner[_tokenId];
    }
}
