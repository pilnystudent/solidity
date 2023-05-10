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

    function add(
        IERC20 sell,
        uint256 sellAmount,
        IERC20 buy,
        uint256 buyAmount
    ) public returns (bool) {
        sell.transferFrom(msg.sender, address(this), sellAmount);
        offers.push(Offer(msg.sender, sell, sellAmount, buy, buyAmount, true));
        emit Add(msg.sender, sell, sellAmount, buy, buyAmount);
        return true;
    }

    function exchange(uint256 index) public returns (bool) {
        Offer storage offer = offers[index];
        if (offer.active == true) {
            offer.sell.transfer(msg.sender, offer.sellAmount);
            offer.buy.transferFrom(msg.sender, offer.seller, offer.buyAmount);
            offer.active = false;
            emit Exchange(msg.sender, offer.seller, offer.sell, offer.sellAmount, offer.buy, offer.buyAmount);
            return true;
        }
        return false;
    }

    event Add(address indexed sender, IERC20 sell, uint256 sellAmount, IERC20 buy, uint256 buyAmount);
    event Exchange(address indexed sender, address indexed recipient, IERC20 sell, uint256 sellAmount, IERC20 buy, uint256 buyAmount);
}
