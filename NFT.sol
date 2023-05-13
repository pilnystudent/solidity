// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import {ERC721} from "./token/ERC721.sol";

contract MyNFT is ERC721 {
    function mint(address to, uint256 id) external {
        _mint(to, id);
    }

    function burn(uint256 id) external {
        require(msg.sender == _ownerOf[id], "not owner");
        _burn(id);
    }
}
