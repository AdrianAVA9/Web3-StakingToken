// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";

contract GreenMonkeyToken is ERC20 {
    constructor() ERC20("GreenMonkey", "GMK") {
        _mint(msg.sender, 1000 * (10 ** uint256(decimals())));
    }
}