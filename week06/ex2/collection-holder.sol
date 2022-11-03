// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./collection.sol";

contract ContractsHolder {
    struct Collectionstruct {
        string name;
        string symbol;
    }

    mapping(address => Collection) public ownerToCollection;
    Collection[] public collections;

    constructor() {}

    function createToken(Collectionstruct memory collectionstruct)
        public
        returns (address)
    {
        require(address(ownerToCollection[msg.sender]) == address(0), "Sender already has a collection!");
        Collection collection = new Collection(
            collectionstruct.name,
            collectionstruct.symbol
        );
        collection.transferOwnership(msg.sender);
        ownerToCollection[msg.sender] = collection;
        collections.push(collection);
        return address(collection);
    }

    function getCollections() external view returns (Collection[] memory){
        return collections;
    }
}
