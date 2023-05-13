// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Gible is ERC20 {
    constructor() ERC20("Gible", "GIBLE") {
        _mint(msg.sender, 1000000000 * 10**decimals());
    }
}
