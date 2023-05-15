// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import {ERC20} from "./token/ERC20.sol";
import {Ownable} from "./access/Ownable.sol";
import {IUSDC} from "./interface/IUSDC.sol";

/*
 * ERC20
 * USDC replica
 * Owner can set minter limit
 * Minter can mint up to limit
 * Minter can burn up to his minted amount
 */

contract USDC is ERC20, Ownable, IUSDC {
    mapping(address => Balance) public mintBalance;

    constructor() ERC20("USD Coin", "USDC") {}

    function updateMinter(address minter, uint256 limit) external onlyOwner {
        mintBalance[minter].limit = limit;
        emit UpdateMinter(minter, limit);
    }

    function mint(address to, uint256 amount) external {
        Balance storage balance = mintBalance[msg.sender];
        balance.minted += amount;
        require(balance.limit >= balance.minted);
        _mint(to, amount);
    }

    function burn(uint256 amount) external {
        mintBalance[msg.sender].minted -= amount;
        _burn(msg.sender, amount);
    }
}
