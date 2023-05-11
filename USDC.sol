// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import {ERC20} from "./token/ERC20.sol";
import {ERC20Permit} from "./token/ERC20Permit.sol";
import {Ownable} from "./access/Ownable.sol";

contract USDC is ERC20, ERC20Permit, Ownable {
    constructor() ERC20("USD Coin", "USDC", 18) {}
}
