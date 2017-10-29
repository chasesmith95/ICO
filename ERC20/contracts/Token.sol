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
	mapping (address => mapping (address => uint256)) approved;

	function totalSupply() constant returns (uint totalSupply) {
		return totalSupply;
	}

  function balanceOf(address _owner) constant returns (uint balance) {
    return balances[_owner];
  }

 	function transfer(address _to, uint _value) returns (bool success) {
		return transferFrom(msg.sender, _to, _value);
 	}

 	function transferFrom(address _from, address _to, uint _value) returns (bool success) {
		if (balanceOf(_from) >= _value) {
			balance[_from] -= _value;
			balance[_to] += _value;
			Transfer(_from, _to, _value);
			return true;
		}
	}

	function approve(address _spender, uint _value) returns (bool success) {
		if (balanceOf(msg.sender) >= _value) {
			approved[msg.sender][_spender] = _value;
			Approval(_owner, _spender, _value);
			return true;
		}
	}

	function allowance(address _owner, address _spender) constant returns (uint remaining) {
		return allowed[_owner][_spender];
	}

	event Transfer(address indexed _from, address indexed _to, uint _value);

	event Approval(address indexed _owner, address indexed _spender, uint _value);
 }
