// Get funds from users
// Withdraw funds
// Set a minimum funding value in USD

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

contract FundMe {
    uint256 public number;
    uint256 public minimumUSD = 50;

    function fund() public payable {
        // payable using when you want to send any token
        // Want to be able to set a minimum fund amount of USD
        // 1. How do we send ETH to this contract?
        number = 5; // when reverting -> this will erase 5 in number and return gas from implement this number to 5
        require(msg.value >= minimumUSD, "Didn't send enough!"); // 1e18 == 1 * 10 ** 18 == 100000000000000000 -> 1 ETH
        //'msg. sender': It is always the address of the account from where the function call came from.
        //'msg. value': The amount of Ether/Wei deposited or withdrawn by the msg. sender.
        // require = if, else = didn't send enough
        // what is reverting?
        // like if require fail, undo any action before, and send remaining gas back,
        // there is a variable number, and if we call the fund function and we didn't send enough value -> the number wont be update to 5

        // how to convert ETH to USD -> oracle
        // block chain can't call the api or http 
        // chain link data feed
    }

    function getPrice() public {
        // ABI of the contract
        // Address of the contract -> Etherium Data Feeds
    }

    function getConversionRate() public {}

    //function withdraw() public {}
}
