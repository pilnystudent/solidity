// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import {ERC20} from "./token/ERC20.sol";
import {ERC20Permit} from "./token/ERC20Permit.sol";
import {Ownable} from "./access/Ownable.sol";

contract USDC is ERC20, ERC20Permit, Ownable {
    constructor() ERC20("USD Coin", "USDC", 18) {}

    mapping(address => bool) public minters;

    modifier onlyMinter() {
        require(minters[msg.sender] == true, "only minter");
        _;
    }

    event UpdateMinter(address indexed minter, bool allow);

    function updateMinter(address minter, bool allow) external onlyOwner returns (bool) {
        require(msg.sender == owner, "only owner can update minter");
        minters[minter] = allow;
        emit UpdateMinter(minter, allow);
        return true;
    }

    function mint(uint256 amount) external onlyMinter returns (bool) {
        require(totalSupply + amount >= amount, "total supply overflow");
        unchecked {
            balanceOf[msg.sender] += amount;
            totalSupply += amount;
        }
        emit Transfer(address(0), msg.sender, amount);
        return true;
    }

    function burn(uint256 amount) external onlyMinter returns (bool) {
        require(balanceOf[msg.sender] >= amount, "insufficient balance");
        unchecked {
            balanceOf[msg.sender] -= amount;
            totalSupply -= amount;
        }
        emit Transfer(msg.sender, address(0), amount);
        return true;
    }
}
