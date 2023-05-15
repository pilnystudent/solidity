// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

abstract contract Shares {
    uint256 private shares;
    mapping(address => uint256) private sharesOf;

    function add(address to, uint256 amount) internal {
        shares += amount;
        sharesOf[to] += amount;
    }

    function remove(address from, uint256 amount) internal {
        shares -= amount;
        sharesOf[from] -= amount;
    }
}
