// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import {ERC20} from "./ERC20/ERC20.sol";

contract WETH is ERC20 {
    function name() public pure returns (string memory) {
        return "Wrapped Ethereum";
    }

    function symbol() public pure returns (string memory) {
        return "WETH";
    }

    function decimals() public pure returns (uint8) {
        return 18;
    }

    function mint() external payable returns (bool) {
        unchecked {
            balanceOf[msg.sender] += msg.value; // Cannot overflow
            totalSupply += msg.value; // Cannot overflow
        }
        emit Transfer(address(0), msg.sender, msg.value);
        return true;
    }

    function burn(uint256 amount) external returns (bool) {
        balanceOf[msg.sender] -= amount;
        unchecked {
            totalSupply -= amount; // Cannot overflow
        }
        payable(msg.sender).transfer(amount);
        emit Transfer(msg.sender, address(0), amount);
        return true;
    }
}
