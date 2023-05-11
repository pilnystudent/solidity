// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import {ERC20} from "./token/ERC20.sol";
import {ERC20Permit} from "./token/ERC20Permit.sol";

contract WETH is ERC20, ERC20Permit {
    constructor() ERC20("Wrapped Ethereum", "WETH", 18) {}

    function deposit() external payable returns (bool) {
        unchecked {
            balanceOf[msg.sender] += msg.value;
            totalSupply += msg.value;
        }
        emit Transfer(address(0), msg.sender, msg.value);
        return true;
    }

    function withdraw(uint256 amount) external returns (bool) {
        require(balanceOf[msg.sender] >= amount, "insufficient balance");
        unchecked {
            balanceOf[msg.sender] -= amount;
            totalSupply -= amount;
        }
        payable(msg.sender).transfer(amount);
        emit Transfer(msg.sender, address(0), amount);
        return true;
    }
}
