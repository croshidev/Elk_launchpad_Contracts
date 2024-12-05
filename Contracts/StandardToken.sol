// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract StandardToken is ERC20, Ownable {
    constructor(
        string memory _name,
        string memory _symbol,
        uint256 initialSupply,
        address creator
    ) ERC20(_name, _symbol) Ownable(msg.sender) {
        _mint(creator, initialSupply);
        renounceOwnership();
    }
}