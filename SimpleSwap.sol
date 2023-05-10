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
        Offer memory offer;
        offer.seller = msg.sender;
        offer.sell = sell;
        offer.sellAmount = sellAmount;
        offer.buy = buy;
        offer.buyAmount = buyAmount;
        offers.push(offer);
        return true;
    }

    function ExchangeWith(uint256 index) public returns (bool) {
        Offer memory offer = offers[index];
        offer.sell.approve(msg.sender, offer.sellAmount);
        offer.sell.transferFrom(address(this), msg.sender, offer.sellAmount);
        offer.buy.transferFrom(msg.sender, offer.seller, offer.buyAmount);
        return true;
    }
}
