pragma solidity ^0.8.7;
// SPDX-License-Identifier: MIT
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract MerdoToken {
    
    string tokenName = "MerdoToken";
    string tokenSymbol = "MRDTKN";
    uint8 tokenDecimals = 18;
    uint256 tokenTotalSupply = 495000000;

    mapping(address => uint256) balances;
    mapping(address => mapping(address => uint)) alloweds;

    constructor() {
        balances[msg.sender] = tokenTotalSupply;
        emit Transfer(address(0), msg.sender, tokenTotalSupply);
    }
    
    function name() view public returns(string memory){
        return tokenName;
    }

    function symbol() view public returns(string memory) {
        return tokenSymbol;
    }

    function decimals() view public returns(uint8) {
        return tokenDecimals;
    }

    function totalSupply() view public returns(uint256) {
        return tokenTotalSupply;
    }

    function balanceOf(address _owner) public view returns (uint256 balance) {
        return balances[_owner];
    }

    function transfer(address receiver, uint256 amount) public returns (bool success) {
        balances[msg.sender] = SafeMath.sub(balances[msg.sender], amount);
        balances[receiver] = SafeMath.add(balances[receiver], amount);
        emit Transfer(msg.sender, receiver, amount);
        return true;
    }

    function approve(address spender, uint256 amount) public returns (bool success) {
        alloweds[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    function transferFrom(address sender, address receiver, uint256 amount) public returns (bool success) {
        balances[sender] = SafeMath.sub(balances[sender], amount);
        balances[receiver] = SafeMath.add(balances[receiver], amount);
        alloweds[receiver][msg.sender] = SafeMath.sub(alloweds[sender][msg.sender], amount);
        emit Transfer(msg.sender, receiver, amount);
        return true;
    }

    function allowance(address owner, address spender) public view returns (uint256 remaining) {
        return alloweds[owner][spender];
    }


    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
}