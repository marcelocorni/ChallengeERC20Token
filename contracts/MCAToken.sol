// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC20 {
  function totalSupply() external view returns (uint256);
  function balanceOf(address account) external view returns (uint256);
  function transfer(address recipient, uint256 amount) external returns (bool);
  function allowance(address owner, address spender) external view returns (uint256);
  function approve(address spender, uint256 amount) external returns (bool);
  function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
  event Transfer(address indexed from, address indexed to, uint256 value);
  event Approval(address indexed owner, address indexed spender, uint256 value);
}

contract MCAToken is IERC20 {
  string public name = "MCA Token";
  string public symbol = "MCA";
  uint8 public decimals = 18;
  uint256 public override totalSupply;
  
  mapping(address => uint256) balances;
  mapping(address => mapping(address => uint256)) allowed;

  constructor(uint256 initialSupply) {
    totalSupply = initialSupply;
    balances[msg.sender] = totalSupply;
    emit Transfer(address(0), msg.sender, totalSupply);
  }

  function balanceOf(address account) external view override returns (uint256) {
    return balances[account];
  }

  function transfer(address recipient, uint256 amount) external override returns (bool) {
    require(amount <= balances[msg.sender], "Insufficient balance");
    balances[msg.sender] -= amount;
    balances[recipient] += amount;
    emit Transfer(msg.sender, recipient, amount);
    return true;
  }

  function allowance(address owner, address spender) external view override returns (uint256) {
    return allowed[owner][spender];
  }

  function approve(address spender, uint256 amount) external override returns (bool) {
    allowed[msg.sender][spender] = amount;
    emit Approval(msg.sender, spender, amount);
    return true;
  }

  function transferFrom(address sender, address recipient, uint256 amount) external override returns (bool) {
    require(amount <= balances[sender], "Insufficient balance");
    require(amount <= allowed[sender][msg.sender], "Insufficient allowance");
    balances[sender] -= amount;
    balances[recipient] += amount;
    allowed[sender][msg.sender] -= amount;
    emit Transfer(sender, recipient, amount);
    return true;
  }
}
