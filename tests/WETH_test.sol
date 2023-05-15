// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.4.22 <0.9.0;

// This import is automatically injected by Remix
import "remix_tests.sol";

// This import is required to use custom transaction context
// Although it may fail compilation in 'Solidity Compiler' plugin
// But it will work fine in 'Solidity Unit Testing' plugin

//import "remix_accounts.sol";
import {WETH} from "../WETH.sol";

// File name has to end with '_test.sol', this file can contain more than one testSuite contracts
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
