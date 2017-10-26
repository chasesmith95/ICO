pragma solidity ^0.4.15;

import './interfaces/ERC20Interface.sol';

/**
 * @title Token
 * @dev Contract that implements ERC20 token standard
 * Is deployed by `Crowdsale.sol`, keeps track of balances, etc.
 */

contract Token is ERC20Interface {

	uint totalSupply = 100;
	mapping (address => uint) public balances;

	function totalSupply() constant returns (uint totalSupply) {
		return totalSupply;
	}

    function balanceOf(address _owner) constant returns (uint balance) {
    	return balances[_owner];
    }

 	function transfer(address _to, uint _value) returns (bool success) {
 		
 	}

 	function transferFrom(address _from, address _to, uint _value) returns (bool success);

	function approve(address _spender, uint _value) returns (bool success);

	function allowance(address _owner, address _spender) constant returns (uint remaining);

	event Transfer(address indexed _from, address indexed _to, uint _value);

	event Approval(address indexed _owner, address indexed _spender, uint _value);

11 }
