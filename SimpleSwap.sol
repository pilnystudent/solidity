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
    }

    Offer[] public offers;

    function Add(
        IERC20 sell,
        uint256 sellAmount,
        IERC20 buy,
        uint256 buyAmount
    ) public returns (bool) {
        sell.transferFrom(msg.sender, address(this), sellAmount);
        offers.push(Offer(msg.sender, sell, sellAmount, buy, buyAmount));
        return true;
    }

    function ExchangeWith(uint256 index) public returns (bool) {
        Offer memory offer = offers[index];
        offer.sell.transfer(msg.sender, offer.sellAmount);
        offer.buy.transferFrom(msg.sender, offer.seller, offer.buyAmount);
        return true;
    }
}
