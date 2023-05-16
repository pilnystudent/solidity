// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import {IERC721} from "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import {Ownable} from "./access/Ownable.sol";

struct Ask {
    address owner;
    IERC721 nft;
    uint256 nftId;
    uint256 price;
    bool active;
}

contract NFTMarketplace is Ownable {
    Ask[] public ask;

    function createAsk(
        IERC721 nft,
        uint256 nftId,
        uint256 price
    ) external {
        ask.push(Ask(msg.sender, nft, nftId, price, true));
        nft.transferFrom(msg.sender, address(this), nftId);
    }

    function cancelAsk(uint256 askId) external {
        require(ask[askId].owner == msg.sender);
        require(ask[askId].active == true);
        ask[askId].active = false;
        ask[askId].nft.transferFrom(address(this), msg.sender, ask[askId].nftId);
    }

    function acceptAsk(uint256 askId) external payable {
        require(ask[askId].price == msg.value, "price");
        require(ask[askId].active == true, "active");
        ask[askId].active = false;
        ask[askId].nft.transferFrom(address(this), msg.sender, ask[askId].nftId);
    }

    function withdraw() external onlyOwner {
        payable(msg.sender).transfer(address(this).balance);
    }
}
