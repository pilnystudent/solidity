// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import {ERC20} from "./token/ERC20.sol";
import {Ownable} from "./access/Ownable.sol";
import {IUSDC} from "./interface/IUSDC.sol";

contract USDC is ERC20, Ownable, IUSDC {

    /*////////////////////////////////////////////////////////////
                            CONSTRUCTOR
    ////////////////////////////////////////////////////////////*/

    constructor() ERC20("USD Coin", "USDC", 18) {}

    /*////////////////////////////////////////////////////////////
                            STORAGE
    ////////////////////////////////////////////////////////////*/

    mapping(address => Balance) public minterBalance;

    /*////////////////////////////////////////////////////////////
                            LOGIC
    ////////////////////////////////////////////////////////////*/

    function updateMinter(address minter, uint256 limit) external onlyOwner returns (bool) {
        minterBalance[minter].limit = limit;
        emit UpdateMinter(minter, limit);
        return true;
    }

    function mint(uint256 amount) external returns (bool) {
        require(minterBalance[msg.sender].limit >= minterBalance[msg.sender].minted + amount, "USDC: insufficient mint limit");
        require(totalSupply + amount >= amount, "USDC: total supply overflow");
        unchecked {
            minterBalance[msg.sender].minted += amount;
            balanceOf[msg.sender] += amount;
            totalSupply += amount;
        }
        emit Transfer(address(0), msg.sender, amount);
        return true;
    }

    function burn(uint256 amount) external returns (bool) {
        require(minterBalance[msg.sender].minted >= amount, "USDC: insufficient burn limit");
        require(balanceOf[msg.sender] >= amount, "USDC: insufficient balance");
        unchecked {
            minterBalance[msg.sender].minted -= amount;
            balanceOf[msg.sender] -= amount;
            totalSupply -= amount;
        }
        emit Transfer(msg.sender, address(0), amount);
        return true;
    }
}
