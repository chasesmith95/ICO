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
  Token token;
  //addresses
  //uint price;


  //Owner Functions //
  function CrowdSale() {
    owner = msg.sender;
    uint _totalSupply = msg.value;
    //deploy the token
    token = Token(msg.value);
  }



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
  event Purchase(address _to, uint _value);

  event Refund(address _to, uint _value);

}
