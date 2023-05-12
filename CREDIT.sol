// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import {ERC20} from "./token/ERC20.sol";

contract CREDIT is ERC20 {
    /*////////////////////////////////////////////////////////////
                            CONSTRUCTOR
    ////////////////////////////////////////////////////////////*/

    constructor() ERC20("Credit", "CREDIT") {
        _mint(msg.sender, 1000000000 * 10**decimals);
    }

    function burn(uint256 amount) external {
        _burn(msg.sender, amount);
    }
}
