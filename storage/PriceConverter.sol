// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

// This is similar to Contract but 
// cant have state variable cant send ETH
// and all function in library are internal
library PriceConverter {
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
         */
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
        
        
    }
}