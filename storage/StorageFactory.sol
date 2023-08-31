// SPDX-License-Identifier: MIT 

pragma solidity ^0.8.7;

import "./SimpleStorage.sol"; 

contract StorageFactory {
    
    SimpleStorage[] public simpleStorageArray;
    
    function createSimpleStorageContract() public {
        // make a new SimpleStorage and push into upper Array
        SimpleStorage simpleStorage = new SimpleStorage();
        simpleStorageArray.push(simpleStorage);
    }
    
    function sfStore(uint256 _simpleStorageIndex, uint256 _simpleStorageNumber) public {
        // Address 
        // ABI - Application Binary Interface
        // SimpleStorage(address(simpleStorageArray[_simpleStorageIndex])).store(_simpleStorageNumber); == the meaning of below code
        simpleStorageArray[_simpleStorageIndex].store(_simpleStorageNumber);
        // same with this
        // SimpleStorage simpleStorage = simpleStorageArray[_simpleStorageIndex];
        // simpleStorage.store(_simpleStorageNumber);
    }
    
    function sfGet(uint256 _simpleStorageIndex) public view returns (uint256) {
        // return SimpleStorage(address(simpleStorageArray[_simpleStorageIndex])).retrieve();
        return simpleStorageArray[_simpleStorageIndex].retrieve();
        // Same with this
        // SimpleStorage simpleStorage = simpleStorageArray[_simpleStorageIndex];
        // return simpleStorage.retriveve();
    }
}