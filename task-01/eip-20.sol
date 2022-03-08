pragma solidity ^0.8.7;
// SPDX-License-Identifier: MIT

contract MerdoToken {
    uint256 tokenTotalSupply = 495000000;

    mapping(address => uint256) balances;
    mapping(address => mapping(address => uint256)) alloweds;

    constructor() {
        balances[msg.sender] = tokenTotalSupply;
        emit Transfer(address(0), msg.sender, tokenTotalSupply);
    }

    function totalSupply() view public returns(uint256) {
        return tokenTotalSupply;
    }

    function balanceOf(address _owner) public view returns (uint256 balance) {
        return balances[_owner];
    }

    function transfer(address receiver, uint256 amount) public returns (bool success) {
        require(amount <= balances[msg.sender]);
        balances[msg.sender] = balances[msg.sender] - amount;
        balances[receiver] = balances[receiver] + amount;
        emit Transfer(msg.sender, receiver, amount);
        return true;
    }

    function approve(address spender, uint256 amount) public returns (bool success) {
        alloweds[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    function transferFrom(address sender, address receiver, uint256 amount) public returns (bool success) {
        require(amount <= balances[sender]);
        require(amount <= alloweds[sender][msg.sender]);
        transfer(receiver, amount);
        alloweds[receiver][msg.sender] = alloweds[sender][msg.sender] - amount;
        return true;
    }

    function allowance(address owner, address spender) public view returns (uint256 remaining) {
        return alloweds[owner][spender];
    }

    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
}