// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./ERC20/ERC20.sol";

contract USDC is ERC20 {
    address public minter;

    constructor() {
        minter = msg.sender;
    }

    function name() public pure returns (string memory) {
        return "USD Coin";
    }

    function symbol() public pure returns (string memory) {
        return "USDC";
    }

    function decimals() public pure returns (uint8) {
        return 18;
    }

    function mint(address recipient, uint256 amount) external {
        require(msg.sender == minter, "only minter can mint");
        balanceOf[recipient] += amount;
        unchecked {
            totalSupply += amount; // Cannot overflow
        }
        emit Transfer(address(0), recipient, amount);
    }

    function burn(uint256 amount) external {
        balanceOf[msg.sender] -= amount;
        unchecked {
            totalSupply -= amount; // Cannot overflow
        }
        emit Transfer(msg.sender, address(0), amount);
    }
}
