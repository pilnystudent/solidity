// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

interface IUSDC {
    struct Balance {
        uint256 limit;
        uint256 minted;
    }

    event UpdateMinter(address indexed minter, uint256 limit);

    function updateMinter(address minter, uint256 limit) external returns (bool);

    function mint(uint256 amount) external returns (bool);

    function burn(uint256 amount) external returns (bool);
}
