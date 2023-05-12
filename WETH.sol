// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import {ERC20} from "./token/ERC20.sol";
import {IWETH} from "./interface/IWETH.sol";

contract WETH is ERC20, IWETH {
    /*////////////////////////////////////////////////////////////
                            CONSTRUCTOR
    ////////////////////////////////////////////////////////////*/

    constructor() ERC20("Wrapped Ethereum", "WETH") {}

    /*////////////////////////////////////////////////////////////
                            LOGIC PUBLIC
    ////////////////////////////////////////////////////////////*/

    function deposit() external payable  {
        _mint(msg.sender, msg.value);
    }

    function withdraw(uint256 amount) external  {
        _burn(msg.sender, amount);
        payable(msg.sender).transfer(amount);
    }
}
