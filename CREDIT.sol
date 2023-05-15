// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import {ERC20} from "./token/ERC20.sol";

/*
 * ERC20
 * public unowned mint
 * 1 CREDIT = 1 second
 */

contract CREDIT is ERC20 {
    uint256 private lastMint;

    constructor() ERC20("Credit", "CREDIT") {
        lastMint = block.timestamp;
    }

    function mint() external {
        _mint(msg.sender, mintReward());
        lastMint = block.timestamp;
    }

    function mintReward() public view returns (uint256) {
        return block.timestamp - lastMint;
    }
}
