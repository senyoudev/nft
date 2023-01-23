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

    function _baseURI() internal pure override returns (string memory) {
      return "ipfs://QmWZVU3tmn59N7jw241nk2ZgE1q8i2MwUbWKJjyLk141k1/";
    }

    function tokenURI(uint256 tokenId) public view virtual override returns(string memory) {
      string memory currentBaseURI = _baseURI();
      return bytes(currentBaseURI).length > 0 ? string(abi.encodePacked(currentBaseURI,Strings.toString(tokenId),".json")) : "";
    }
}
