// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import {ERC20} from "./token/ERC20.sol";
import {ERC20Permit} from "./token/ERC20Permit.sol";
import {Ownable} from "./access/Ownable.sol";

contract USDC is ERC20, ERC20Permit, Ownable {
    constructor() ERC20("USD Coin", "USDC", 18) {}

    struct Mintable {
        uint256 limit;
        uint256 minted;
    }

    mapping(address => Mintable) public minterBalance;

    event UpdateMinter(address indexed minter, uint256 limit);

    function updateMinter(address minter, uint256 limit) external onlyOwner returns (bool) {
        minterBalance[minter].limit = limit;
        emit UpdateMinter(minter, limit);
        return true;
    }

    function mint(uint256 amount) external returns (bool) {
        require(minterBalance[msg.sender].limit >= minterBalance[msg.sender].minted + amount, "insufficient mint limit");
        require(totalSupply + amount >= amount, "total supply overflow");
        unchecked {
            minterBalance[msg.sender].minted += amount;
            balanceOf[msg.sender] += amount;
            totalSupply += amount;
        }
        emit Transfer(address(0), msg.sender, amount);
        return true;
    }

    function burn(uint256 amount) external returns (bool) {
        require(minterBalance[msg.sender].minted >= amount, "insufficient burn limit");
        require(balanceOf[msg.sender] >= amount, "insufficient balance");
        unchecked {
            minterBalance[msg.sender].minted -= amount;
            balanceOf[msg.sender] -= amount;
            totalSupply -= amount;
        }
        emit Transfer(msg.sender, address(0), amount);
        return true;
    }
}
