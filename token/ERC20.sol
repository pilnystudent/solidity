// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {IERC20Metadata} from "@openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol";

abstract contract ERC20 is IERC20, IERC20Metadata {
    /*////////////////////////////////////////////////////////////
                            STORAGE
    ////////////////////////////////////////////////////////////*/

    string public name;
    string public symbol;
    uint8 public decimals;
    uint256 public totalSupply;
    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;

    /*////////////////////////////////////////////////////////////
                            CONSTRUCTOR
    ////////////////////////////////////////////////////////////*/

    constructor(string memory _name, string memory _symbol) {
        name = _name;
        symbol = _symbol;
        decimals = 18;
    }

    /*////////////////////////////////////////////////////////////
                            LOGIC INTERNAL
    ////////////////////////////////////////////////////////////*/

    function _mint(address account, uint256 amount) internal {
        totalSupply += amount;
        unchecked {
            balanceOf[account] += amount;
        }
        emit Transfer(address(0), account, amount);
    }

    function _burn(address account, uint256 amount) internal {
        balanceOf[account] -= amount;
        unchecked {
            totalSupply -= amount;
        }
        emit Transfer(account, address(0), amount);
    }

    function _transfer(
        address from,
        address to,
        uint256 amount
    ) internal {
        balanceOf[from] -= amount;
        unchecked {
            balanceOf[to] += amount;
        }
        emit Transfer(from, to, amount);
    }

    function _approve(
        address owner,
        address spender,
        uint256 amount
    ) internal {
        allowance[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }

    function _spendAllowance(
        address owner,
        address spender,
        uint256 amount
    ) internal {
        allowance[owner][spender] -= amount;
        emit Approval(owner, spender, allowance[owner][spender]);
    }

    /*////////////////////////////////////////////////////////////
                            LOGIC PUBLIC
    ////////////////////////////////////////////////////////////*/

    function approve(address spender, uint256 amount) external returns (bool) {
        _approve(msg.sender, spender, amount);
        return true;
    }

    function transfer(address to, uint256 amount) external returns (bool) {
        _transfer(msg.sender, to, amount);
        return true;
    }

    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) external returns (bool) {
        _spendAllowance(from, msg.sender, amount);
        _transfer(from, to, amount);
        return true;
    }
}
