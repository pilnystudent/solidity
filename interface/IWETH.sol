// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

interface IWETH {
    function deposit() external payable returns (bool);

    function withdraw(uint256 amount) external returns (bool);
}
