// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.22 <0.9.0;

import "remix_tests.sol";
//import "remix_accounts.sol";
import {WETH} from "../WETH.sol";

contract testSuite {
    WETH weth;

    function beforeEach() public {
        weth = new WETH();
    }

    function checkSymbol() public returns (bool) {
        return Assert.equal(keccak256(abi.encodePacked(weth.symbol())), keccak256(abi.encodePacked("WETH")), "initial value is not correct");
    }

    function checkTotalSupply() public returns (bool) {
        return Assert.equal(weth.totalSupply(), 0, "initial value is not correct");
    }
}
