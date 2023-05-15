// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

abstract contract Vault {
    IERC20 internal token = token;
    uint256 private totalSupply;
    mapping(address => uint256) private balanceOf;

    constructor(address _token) {
        token = IERC20(_token);
    }

    function _add(address to, uint256 shares) internal {
        totalSupply += shares;
        balanceOf[to] += shares;
    }

    function _remove(address from, uint256 shares) internal {
        totalSupply -= shares;
        balanceOf[from] -= shares;
    }

    function deposit(uint256 amount) external {
        uint256 shares;
        if (totalSupply == 0) {
            shares = amount;
        } else {
            shares = (amount * totalSupply) / token.balanceOf(address(this));
        }
        _add(msg.sender, shares);
        token.transferFrom(msg.sender, address(this), amount);
    }

    function withdraw(uint256 shares) external {
        uint256 amount = (shares * token.balanceOf(address(this))) / totalSupply;
        _remove(msg.sender, shares);
        token.transfer(msg.sender, amount);
    }
}
