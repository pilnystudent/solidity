// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {ERC721} from "./draft/ERC721.sol";
import {Ownable} from "./access/Ownable.sol";

contract TNFT is ERC721, Ownable {
    uint256 private counter;
    mapping(uint256 => mapping(IERC20 => uint256)) public reward;

    function mint() external onlyOwner {
        _mint(msg.sender, counter);
        counter += 1;
    }

    function depositReward(
        uint256 id,
        IERC20 token,
        uint256 amount
    ) public {
        token.transferFrom(msg.sender, address(this), amount);
        reward[id][token] = amount;
    }

    function withdrawReward(
        uint256 id,
        IERC20 token,
        uint256 amount
    ) public {
        require(msg.sender == _ownerOf[id]);
        require(reward[id][token] >= amount);
        token.transfer(msg.sender, amount);
    }
}
