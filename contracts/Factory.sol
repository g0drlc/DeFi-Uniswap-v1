// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import "./Exchange.sol";

contract Factory {
    mapping(address => address) public tokenToExchange;
    mapping(address => address) public exchangeToToken;
    mapping(uint256 => address) public idToToken;
    Exchange[] public exchangeArray;

    event ExchangeCreated(address indexed tokenAddress, address indexed exchangeAddress);

    function createNewExchange(address _tokenAddress) public returns(address) {
        require (_tokenAddress != address(0), "Invalid token address");
        require(tokenToExchange[_tokenAddress] == address(0),"exchange already exists");
        Exchange exchange = new Exchange(_tokenAddress);
        exchangeArray.push(exchange);
        tokenToExchange[_tokenAddress] = address(exchange);
        emit ExchangeCreated(_tokenAddress, address(exchange));
        return address(exchange);
    }

    function getExchange(address _tokenAddress) public view returns(address) {
        return tokenToExchange[_tokenAddress];
    }

    function getToken(address _exchange) public view returns (address) {
        return exchangeToToken[_exchange];
    }

    function getTokenWithId(uint256 _tokenId) public view returns (address) {
        return idToToken[_tokenId];
    }
}