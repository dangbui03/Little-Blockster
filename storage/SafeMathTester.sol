// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract SafeMathTester {
    uint8 public bigNumber =255; // max size of uint8
    // after hiting this function bignumber reset the value to 0 when in version 0.6.0 solidity because it was uncheck variable
    // after hiting this function it fail and bigNumber still 255 when in version 0.8.0 solidity because it was check variable
    // overflow
    function add() public {
        unchecked {
            bigNumber = bigNumber + 1;
        } // if you have this -> the bigNumber will reset to 0 because it now unchecked
    }
    


}