pragma solidity ^0.4.15;

import './Queue.sol';
import './Token.sol';

/**
 * @title Crowdsale
 * @dev Contract that deploys `Token.sol`
 * Is timelocked, manages buyer queue, updates balances on `Token.sol`
 */

contract Crowdsale {
	// YOUR CODE HERE
  address owner;
  Token public token;
  Queue public queue;
  //addresses
  //uint price;
  using SafeMath for uint256;
  uint256 public startSale;
  uint256 public endSale;
  uint256 public rate;
  uint256 public fundsRaised;
  uint256 public tokensSold;


  //Owner Functions //
  function CrowdSale(uint256 timeLimit, uint256 supply, uint256 _rate) {
    require(timeLimit > 0);
    owner = msg.sender;
    token = new Token(supply);
    //deploy the token
    startSale = now;
    endSale = SafeMath.add(startSale, timeLimit);
    rate = _rate;
    queue = new Queue();
    tokensSold = 0;
    fundsRaised = 0;
  }

  function mint(uint256 numTokens) {
    require(msg.sender == owner);
    token.mint(numTokens);
  }

  function burn(uint256 numTokens) returns (bool) {
    require(msg.sender == owner);
    return token.burnTokens(numTokens);
  }

  function buyTokens() payable returns (bool) {
    require(now <= startSale);
    uint256 numTokens = SafeMath.mul(msg.value, rate);
    if (token.totalSupply() >= numTokens && queue.getFirst() == msg.sender && queue.qsize() > 1) {
      bool valid = token.transfer(msg.sender, numTokens);
      if (valid) {
        tokensSold = SafeMath.add(tokensSold, numTokens);
        fundsRaised = SafeMath.add(fundsRaised, msg.value);
      }
      TokenPurchase(msg.sender, msg.value, valid);
      return valid;
    }
    return false;
  }

  function refund(uint256 amnt) returns (bool) {
    require(now <= startSale);
    bool valid = token.transfer(msg.sender, amnt);
    if (valid) {
      tokensSold = SafeMath.sub(tokensSold, amnt);
      uint256 numWei = SafeMath.div(amnt, rate);
      valid = msg.sender.send(numWei);
      if (valid) {
        fundsRaised = SafeMath.sub(fundsRaised, numWei);
      }
    }
    TokenRefund(msg.sender, msg.value, valid);
    return valid;
  }

  function getFunds() returns (bool) {
    require(msg.sender == owner);
    bool valid = owner.send(fundsRaised);
    if (valid) {
      fundsRaised = 0;
    }
    return valid;
  }

  // function getInLine() {
  //   queue.enqueue(msg.sender);
  // }

  // function checkPlaceInLine() returns (uint8) {
  //   return queue.checkPlace();
  // }

  // function checkFront() returns (address) {
  //   return queue.getFirst();
  // }

  // function checkTime() {
  //   queue.checkTime();
  // }


  modifier isOwner(address _owner) {require(owner == _owner); _;}
  //set start and end time in a time cap

//Events //
  event TokenPurchase(address _to, uint _value, bool success);

  event TokenRefund(address _to, uint _value, bool success);

}
