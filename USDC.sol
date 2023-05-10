// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import {ERC20} from "./ERC/ERC20.sol";

contract USDC is ERC20 {
    function name() public pure returns (string memory) {
        return "USD Coin";
    }

    function symbol() public pure returns (string memory) {
        return "USDC";
    }

    function decimals() public pure returns (uint8) {
        return 18;
    }

    function mint(uint256 amount) external returns (bool) {
        balanceOf[msg.sender] += amount;
        unchecked {
            totalSupply += amount; // Cannot overflow
        }
        emit Transfer(address(0), msg.sender, amount);
        return true;
    }

    function burn(uint256 amount) external returns (bool) {
        balanceOf[msg.sender] -= amount;
        unchecked {
            totalSupply -= amount; // Cannot overflow
        }
        emit Transfer(msg.sender, address(0), amount);
        return true;
    }
}
