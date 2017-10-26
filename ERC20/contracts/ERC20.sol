pragma solidity ^0.4.4;

import "./ConvertLib.sol";

// This is just a simple example of a coin-like contract.
// It is not standards compatible and cannot be expected to talk to other
// coin/token contracts. If you want to create a standards-compliant
// token, see: https://github.com/ConsenSys/Tokens. Cheers!

contract ERC20 {
			uint totalSupply = 100;

 3     function totalSupply() constant returns (uint totalSupply);

 4     function balanceOf(address _owner) constant returns (uint balance);

 5     function transfer(address _to, uint _value) returns (bool success);

 6     function transferFrom(address _from, address _to, uint _value) returns (bool success);

 7     function approve(address _spender, uint _value) returns (bool success);

 8     function allowance(address _owner, address _spender) constant returns (uint remaining);

 9     event Transfer(address indexed _from, address indexed _to, uint _value);

10     event Approval(address indexed _owner, address indexed _spender, uint _value);

11 }
