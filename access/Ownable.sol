// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

abstract contract Ownable {
    address public owner;

    event UpdateOwner(address indexed owner);

    constructor() {
        owner = msg.sender;
    }

    function updateOwner(address newOwner) external returns (bool) {
        require(msg.sender == owner, "only owner can update owner");
        owner = newOwner;
        emit UpdateOwner(newOwner);
        return true;
    }
}
