// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./ERC20/ERC20.sol";

contract MYUSD is ERC20 {
    function name() public pure returns (string memory) {
        return "USD Coin";
    }

    function symbol() public pure returns (string memory) {
        return "USDC";
    }

    function decimals() public pure returns (uint8) {
        return 18;
    }
}
