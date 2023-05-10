// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./ERC20/ERC20.sol";

contract MYUSD is ERC20 {
    function name() public pure returns (string memory) {
        return "USD Example";
    }

    function symbol() public pure returns (string memory) {
        return "USDE";
    }

    function decimals() public pure returns (uint8) {
        return 18;
    }
}
