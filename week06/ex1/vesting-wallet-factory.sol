// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.7.3/contracts/proxy/Clones.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.7.3/contracts/access/Ownable.sol";
import "./vesting-wallet.sol";

contract VestingWalletFactory is Ownable {
    
    address[] private vestingWallets;
    uint numVestingWallets;

    constructor(address vestingWalletImplementation_) Ownable() {}

    function createVestingWallet(
        address beneficiary,
        uint64 start,
        uint64 duration
    ) external onlyOwner {
        VestingWallet vestingWallet = new VestingWallet(beneficiary, start, duration, payable(msg.sender));
        vestingWallets[numVestingWallets] = address(vestingWallet);
        numVestingWallets++;
    }

    function getVestingWallets() external view onlyOwner returns (address[] memory) {
        return vestingWallets;
    }
}
