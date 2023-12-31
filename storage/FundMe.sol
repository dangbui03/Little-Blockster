// SPDX-License-Identifier:MIT
pragma solidity ^0.8.8;

import "./PriceConverter.sol";

// Get funds from users
// Withdraw funds
// Set a minimum funding value in USD

/**
interface AggregatorV3Interface {
  function decimals() external view returns (uint8);

  function description() external view returns (string memory);

  function version() external view returns (uint256);

  function getRoundData(
    uint80 _roundId
  ) external view returns (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound);

  function latestRoundData()
    external
    view
    returns (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound);
}
 */
error NotOwner();

contract FundMe {
    using PriceConverter for uint256;

    uint256 public number;
    uint256 public constant MINIMUM_USD = 50 * 1e18; // 1 * 10 ** 18
    // constant reduce the amount of gas
    // 21,415 gas - constant
    // 23,515 gas - non-constant
    // 21,415 * 141000000000 = $9,058545
    // 23,515 * 141000000000 = $9,946845 -> approximately $1 more

    address[] public funders; // array for the address of user
    mapping(address => uint256) public addressToAmountFunded;

    address public immutable i_owner;

    constructor() {
        i_owner = msg.sender;
    }

    function fund() public payable {
        // payable using when you want to send any token
        // Want to be able to set a minimum fund amount of USD
        // 1. How do we send ETH to this contract?
        number = 5; // when reverting -> this will erase 5 in number and return gas from implement this number to 5
        require(
            msg.value.getConversionRate() >= MINIMUM_USD,
            "Didn't send enough!"
        ); // 1e18 == 1 * 10 ** 18 == 100000000000000000 -> 1 ETH
        // msg.value.getConversionRate() ==== getConversionRate(msg.value)
        // 18 decimals
        //'msg. sender': It is always the address of the account from where the function call came from. / address call the function
        //'msg. value': The amount of Ether/Wei deposited or withdrawn by the msg.sender. / the how much crypto currency sender send
        // require = if, else = didn't send enough
        // what is reverting?
        // like if require fail, undo any action before, and send remaining gas back,
        // there is a variable number, and if we call the fund function and we didn't send enough value -> the number wont be update to 5

        // how to convert ETH to USD -> oracle
        // block chain can't call the api or http
        // chain link data feed

        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] += msg.value;
    }

    function withdraw() public onlyOwner {
        // but everyone can withdraw with thiss function

        /*for loop -> starting index, ending index, step amout */
        for (
            uint256 funderIndex = 0;
            funderIndex < funders.length;
            funderIndex++
        ) {
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0; //reset the array
        }
        funders = new address[](0); // another reset array way
        // actually withdraw the funds

        // How to send Ether:
        // msg.sender = address
        // payable(msg.sender) = payable address
        // transfer (2300gas, throws err)
        payable(msg.sender).transfer(address(this).balance); // chuyển cho người nhận
        // send (2300 gas, return bool)
        bool sendSuccess = payable(msg.sender).send(address(this).balance);
        require(sendSuccess, "Send Failed");
        // call (forward all gas or set gas, returns bool)
        (bool callSuccess, bytes memory dataReturned) = payable(msg.sender)
            .call{value: address(this).balance}("");
        require(callSuccess, "Call Failed");
    }

    modifier onlyOwner() {
        //require(msg.sender == i_owner, notOwner()); // when you call any function like withdraw -> this line will go first
        // You can reduce the gas cosume by doing this
        if(msg.sender != i_owner) {
            revert NotOwner();
        }
        _; // and then doing the rest of code of withdraw function
    }
    
    //what happens if someone sends this contract ETH without calling the fund function
    // receive() - fallback()
    receive() external payable {
        fund();
    }

    fallback() external payable {
        fund();
    }

    /* Move to PriceConverter.sol
        function getPrice() public view returns(uint256) {
        // ABI of the contract
        // Address of the contract -> Etherium Data Feeds
        // change the USD into ETH or reverse -> through Oracle
        // 0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e - Goerli
        /**
            AggregatorV3Interface priceFeed = AggregatorV3Interface(
            0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e
        );
        (
            uint80 roundId,
            int price,
            uint startedAt,
            uint timeStamp,
            uint80 answeredInAround
        ) = priceFeed.latestRoundData();
         * /
        (,int256 price,,,) = priceFeed.lastestRoundDataa();
        // ETH in terms of USD
        // 3000.00000000
        return uint256 (price * 1e10); // 1**10 = 10000000000
    }

    function getVersion() public view returns (uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(
            0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e
        );
        return priceFeed.version();
    }
    function getConversionRate(uint256 ethAmount) public view returns(uint256){
        // 3000_000000000000000000 = ETH / USD price
        // 1_000000000000000000 ETH (amount)
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUSD = (ethPrice * ethPrice) / 1e18;
        // 2999.99999999999999999 -> we dont do decimal math in solidity -> 3000_000000000000000000
        return ethAmountInUSD;        
    } */
}
