// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.22 <0.9.0;

import "remix_tests.sol";
import "remix_accounts.sol";
import {WETH} from "../WETH.sol";

contract testWETH is WETH {
    address acc0;

    function beforeAll() public {
        acc0 = TestsAccounts.getAccount(0);
    }

    function checkSymbol() public returns (bool) {
        return Assert.equal(keccak256(abi.encodePacked(this.symbol())), keccak256(abi.encodePacked("WETH")), "initial value is not correct");
    }

    function checkTotalSupply() public returns (bool) {
        return Assert.equal(this.totalSupply(), 0, "initial value is not correct");
    }

    /// #value: 500
    function checkMintAndTransfer() public payable returns (bool) {
        this.deposit{value: 500}();
        Assert.equal(this.balanceOf(address(this)), 500, "balance value is not correct");
        this.transfer(acc0, 100);
        Assert.equal(this.balanceOf(acc0), 100, "transferred value is not correct");
        return Assert.equal(this.totalSupply(), 500, "total supply value is not correct");
    }
}
