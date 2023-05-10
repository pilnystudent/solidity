// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./ERC20/ERC20.sol";

contract SimpleSwap {
    struct Offer {
        address seller;
        IERC20 sell;
        uint256 sellAmount;
        IERC20 buy;
        uint256 buyAmount;
        bool active;
    }

    Offer[] public offers;

    function Add(
        IERC20 sell,
        uint256 sellAmount,
        IERC20 buy,
        uint256 buyAmount
    ) public returns (bool) {
        sell.transferFrom(msg.sender, address(this), sellAmount);
        offers.push(Offer(msg.sender, sell, sellAmount, buy, buyAmount, true));
        return true;
    }

    function Exchange(uint256 index) public returns (bool) {
        Offer storage offer = offers[index];
        if (offer.active == true) {
            offer.sell.transfer(msg.sender, offer.sellAmount);
            offer.buy.transferFrom(msg.sender, offer.seller, offer.buyAmount);
            offer.active = false;
            return true;
        }
        return false;
    }
}
