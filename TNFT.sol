// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {ERC721} from "./draft/ERC721.sol";
import {Ownable} from "./access/Ownable.sol";

contract TNFT is ERC721, Ownable {
    uint256 private counter;
    mapping(uint256 => mapping(address => uint256)) private reward;

    function mint() external onlyOwner {
        _mint(msg.sender, counter);
        counter += 1;
    }

    function depositReward(
        uint256 id,
        address token,
        uint256 amount
    ) public {
        IERC20(token).transferFrom(msg.sender, address(this), amount);
        reward[id][token] = amount;
    }

    function withdrawReward(
        uint256 id,
        address token,
        uint256 amount
    ) public {
        require(msg.sender == _ownerOf[id]);
        require(reward[id][token] >= amount);
        IERC20(token).transfer(msg.sender, amount);
    }

    function rewardBalance(uint256 id, address token) public view returns (uint256) {
        return reward[id][token];
    }
}
