// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

/**
 * @title Storage
 * @dev Store & retrieve value in a variable
 * @custom:dev-run-script ./scripts/deploy_with_ethers.ts
 */
contract Storage {

   function add(uint a, uint b) public pure returns (uint256){
        return a + b;
    }

    function sub(uint a, uint b) public pure returns (uint256){
        return a - b;
    }

    function mul(uint a, uint b) public pure returns (uint256){
        return a * b;
    }

    function div(uint a, uint b) public pure returns (uint256){
        require(b > 0, "Can't divide by zero");
        return a / b;
    }
}
