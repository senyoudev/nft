pragma solidity 0.8.16;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract NFT is ERC721 {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIdCounter;

    mapping(uint256 => address) public tokenOwner;
    mapping(uint256 => bool) public tokenExists;

    constructor() ERC721("leprogrammeurmarocain", "pgmar") {}

    function mint(address _to) public returns (uint256) {
        _tokenIdCounter.increment();
        tokenOwner[_tokenIdCounter.current()] = _to;
        tokenExists[_tokenIdCounter.current()] = true;
        _safeMint(_to, _tokenIdCounter.current());

        return _tokenIdCounter.current();
    }

    function ownerOf(uint256 _tokenId) public view override returns (address) {
        require(tokenExists[_tokenId], "token does not exist");
        return tokenOwner[_tokenId];
    }
}
