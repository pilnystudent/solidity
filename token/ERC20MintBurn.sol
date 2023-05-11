// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./ERC20.sol";

abstract contract ERC20MintBurn is ERC20 {
    address public owner;

    mapping(address => uint256) public mintAllowance;

    event UpdateMinter(address indexed minter, uint256 amount);

    function updateMinter(address minter, uint256 amount) external returns (bool) {
        require(msg.sender == owner, "only owner can update minter");
        mintAllowance[minter] = amount;
        emit UpdateMinter(minter, amount);
        return true;
    }

    function mint(uint256 amount) external returns (bool) {
        require(mintAllowance[msg.sender] >= amount, "insufficient mint allowance");
        require(totalSupply + amount >= amount, "total supply overflow");
        unchecked {
            mintAllowance[msg.sender] -= amount;
            balanceOf[msg.sender] += amount;
            totalSupply += amount;
        }
        emit Transfer(address(0), msg.sender, amount);
        return true;
    }

    function burn(uint256 amount) external returns (bool) {
        require(mintAllowance[msg.sender] <= amount);
        require(balanceOf[msg.sender] >= amount, "insufficient balance");
        unchecked {
            mintAllowance[msg.sender] -= amount;
            balanceOf[msg.sender] -= amount;
            totalSupply -= amount;
        }
        emit Transfer(msg.sender, address(0), amount);
        return true;
    }
}
