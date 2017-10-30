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


  //Owner Functions //
  function CrowdSale(uint256 timeLimit, uint256 supply, uint256 _rate) {
    require(timeLimit > 0);
    owner = msg.sender;
    token = new Token(supply);
    //deploy the token
    startSale = now;
    endSale = SafeMath.add(startSale, timeLimit);
    rate = _rate;
    quueue = new Queue();
  }

  function mint(uint256 numTokens) {
    require(msg.sender == owner);
    token.mint(numTokens);
  }

  function burn(uint256 numTokens) returns (bool) {
    require(msg.sender == owner);
    return token.burn(numTokens);
  }

  function buyTokens() payable returns (bool) {
    require(now <= startSale);
    
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


  function setTimeCap(start, end) isOwner(msg.sender);
  //Unknown how to do this

  //Token Supply Issues //
    //initialize token supply

    //be able to mint new tokens

  //set price
  function setPrice(uint _price) isOwner(msg.sender) {
    if (_price > 0) {
      price = _price;
    }
  }

  //Burn Tokens not yet Sold //
    //be able to burn tokens not yet sold (subtract from totalSupply)
  function Burn() isOwner(msg.sender);


  //Buyer Functions //

  function Purchase(uint _value) returns (bool success);

  function Refund(uint _value) returns (bool success);





  //Ending Functions //

    //must give all funds to the owner at the end of the sale


//Events //
  event TokenPurchase(address _to, uint _value);

  event TokenRefund(address _to, uint _value);

}
