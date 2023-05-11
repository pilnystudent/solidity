// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import {ERC20} from "./token/ERC20.sol";
import {ERC20Owner} from "./token/ERC20Owner.sol";
import {ERC20Permit} from "./token/ERC20Permit.sol";

contract USDC is ERC20, ERC20Owner, ERC20Permit {
    constructor() ERC20("USD Coin", "USDC", 18) {}
}
