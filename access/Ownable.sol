// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

abstract contract Ownable {
    address public owner;

    event UpdateOwner(address indexed owner);

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "only owner");
        _;
    }

    function updateOwner(address newOwner) external onlyOwner {
        owner = newOwner;
        emit UpdateOwner(newOwner);
    }
}
