// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import {ERC20} from "./ERC20.sol";
import {IERC20Permit} from "@openzeppelin/contracts/token/ERC20/extensions/draft-IERC20Permit.sol";

abstract contract ERC20Permit is ERC20, IERC20Permit {
    bytes32 public DOMAIN_SEPARATOR;

    mapping(address => uint256) public nonces;

    constructor() {
        DOMAIN_SEPARATOR = keccak256(abi.encode(keccak256("EIP712Domain(string name,string version,uint256 chainId,address verifyingContract)"), keccak256(bytes(name)), keccak256("1"), block.chainid, address(this)));
    }

    function permit(
        address owner,
        address spender,
        uint256 value,
        uint256 deadline,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) public virtual {
        require(deadline >= block.timestamp, "permit expired");
        unchecked {
            bytes32 digest = keccak256(abi.encodePacked("\x19\x01", DOMAIN_SEPARATOR, keccak256(abi.encode(keccak256("Permit(address owner,address spender,uint256 value,uint256 nonce,uint256 deadline)"), owner, spender, value, nonces[owner]++, deadline))));
            address recoveredAddress = ecrecover(digest, v, r, s);
            require(recoveredAddress != address(0) && recoveredAddress == owner, "invalid signer");
            allowance[recoveredAddress][spender] = value;
        }
        emit Approval(owner, spender, value);
    }
}
