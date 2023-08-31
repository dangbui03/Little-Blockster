// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

import "./SimpleStorage.sol";

//inheritance
contract ExtraStorage is SimpleStorage {
    // You want your function in SimpleStorage do something else -> like +5
    // override
    // vitural & override 
    // The purpose of these keywords is to be more explicit when overriding a function.
    // Base functions can be overridden by inheriting contracts to change their behavior if they are marked as virtual. 
    // The overriding function must then use the override keyword in the function header.
    function store(uint256 _favoriteNumber) public override {
        favoriteNumber = _favoriteNumber + 5;
    }
}
