pragma solidity ^0.4.15;

import './interfaces/ERC20Interface.sol';
import './utils/SafeMath.sol';

/**
 * @title Token
 * @dev Contract that implements ERC20 token standard
 * Is deployed by `Crowdsale.sol`, keeps track of balances, etc.
 */

contract Token is ERC20Interface {

	uint256 public totalSupply;
	mapping (address => uint) public balances;
	mapping (address => mapping (address => uint256)) approved;
	using SafeMath for uint256;
	address ownerOfToken;

	function Token(uint256 _totalSupply) {
		totalSupply = _totalSupply;
		balances[msg.sender] += totalSupply;
	}

  	function balanceOf(address _owner) constant returns (uint balance) {
		return balances[_owner];
  	}

  	function mint(uint256 addSupply) {
	  	require (msg.sender == ownerOfToken);
	  	totalSupply = SafeMath.add(totalSupply, addSupply);
	  	balances[msg.sender] = SafeMath.add(balances[msg.sender], addSupply);
  	}
  
	function burnTokens(uint _value) returns (bool success) {
		if (balanceOf(msg.sender) >= _value && _value > 0) {
			totalSupply -= _value;
			balances[msg.sender] -= _value;
			return true;
			}
	}

	function refund(address _from, uint256 _amnt) returns (bool) {
		require (msg.sender == ownerOfToken);
	}

	function transfer(address _to, uint _value) returns (bool success) {
	  	return transferFrom(msg.sender, _to, _value);
	}
	
	function totalSupply() returns (uint256) {
		return totalSupply;
	}
	  
	function transferFrom(address _from, address _to, uint _value) returns (bool success) {
		if (balanceOf(_from) >= _value) {
			balances[_from] -= _value;
			balances[_to] += _value;
			Transfer(_from, _to, _value);
			return true;
		}
	}

	function approve(address _spender, uint _value) returns (bool success) {
		if (balanceOf(msg.sender) >= _value) {
			approved[msg.sender][_spender] = _value;
			Approval(msg.sender, _spender, _value);
			return true;
		}
	}

	function allowance(address _owner, address _spender) constant returns (uint remaining) {
		return approved[_owner][_spender];
	}

	event Transfer(address indexed _from, address indexed _to, uint _value);

	event Approval(address indexed _owner, address indexed _spender, uint _value);
 }
