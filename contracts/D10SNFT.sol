pragma solidity ^0.7.0;

import '@openzeppelin/contracts/token/ERC721/ERC721.sol';
import "@openzeppelin/contracts/utils/Counters.sol";

contract D10SNFT is ERC721 {
  using Counters for Counters.Counter;
  Counters.Counter private _tokenIds;

  constructor() ERC721('D10SNFT', 'D10S') {}

  function awardItem(address user, string memory tokenURI) public returns (uint256) {
      _tokenIds.increment();

      uint256 newItemId = _tokenIds.current();
      _mint(user, newItemId);
      _setTokenURI(newItemId, tokenURI);

      return newItemId;
  }
}