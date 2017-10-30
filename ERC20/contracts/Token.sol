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
		balances[msg.sender] = safeAdd(balances[msg.sender], totalSupply);
	}

  function balanceOf(address _owner) constant returns (uint balance) {
    return balances[_owner];
  }

  function mint(address _buyer, uint256 _addSupply) {
	  require (buyer != _ownerOfToken && msg.sender == _ownerOfToken);
	  totalSupply = safeAdd(totalSupply, _addSupply);
	  balances[_buyer] = safeAdd(balances[_buyer], _addSupply);
  }

	function burnTokens(uint _value) returns (bool success) {
		if (balanceOf(msg.sender) >= _value && _value > 0) {
			totalSupply = safeSub(totalSupply, _value);
			balances[msg.sender] = safeSub(balances[msg.sender], _value);
			Burn(msg.sender, _value);
			return true;
		}
	}

 	function transfer(address _to, uint _value) returns (bool success) {
		return transferFrom(msg.sender, _to, _value);
 	}

 	function transferFrom(address _from, address _to, uint _value) returns (bool success) {
		if (balanceOf(_from) >= _value) {
			balances[_from] = safeSub(balances[_from], _value);
			balances[_to] = safeAdd(balances[_to], _value);
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

	event Burn(address _burner, uint _value);

	event Transfer(address indexed _from, address indexed _to, uint _value);

	event Approval(address indexed _owner, address indexed _spender, uint _value);
 }
