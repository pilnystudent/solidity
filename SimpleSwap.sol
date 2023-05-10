// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./ERC20/ERC20.sol";

contract SimpleSwap {
    struct Offer {
        address owner;
        IERC20 selling;
        uint256 sellingAmount;
        IERC20 buying;
        uint256 buyingAmount;
        bool active;
    }

    Offer[] public offers;

    function add(
        IERC20 selling,
        uint256 sellingAmount,
        IERC20 buying,
        uint256 buyingAmount
    ) public returns (bool) {
        selling.transferFrom(msg.sender, address(this), sellingAmount);
        offers.push(Offer(msg.sender, selling, sellingAmount, buying, buyingAmount, true));
        emit Add(msg.sender, selling, sellingAmount, buying, buyingAmount);
        return true;
    }

    function exchange(uint256 index) public returns (bool) {
        Offer storage offer = offers[index];
        require(offer.active == true, "offer is inactive");
        offer.selling.transfer(msg.sender, offer.sellingAmount);
        offer.buying.transferFrom(msg.sender, offer.owner, offer.buyingAmount);
        offer.active = false;
        emit Exchange(msg.sender, offer.owner, offer.selling, offer.sellingAmount, offer.buying, offer.buyingAmount);
        return true;
    }

    event Add(address indexed owner, IERC20 selling, uint256 sellingAmount, IERC20 buying, uint256 buyingAmount);
    event Exchange(address indexed sender, address indexed owner, IERC20 selling, uint256 sellingAmount, IERC20 buying, uint256 buyingAmount);
}
