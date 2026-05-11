// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import "forge-std/Test.sol";
import "../contracts/Create2Factory.sol";
contract Create2FactoryTest is Test {
    Create2Factory factory;
    function setUp() public { factory = new Create2Factory(); }
    function test_deployDeterministic() public {
        bytes memory bytecode = type(Create2Factory).creationCode;
        bytes32 salt = keccak256("test");
        address predicted = factory.computeAddress(salt, keccak256(bytecode));
        address deployed = factory.deploy(salt, bytecode);
        assertEq(predicted, deployed);
    }
}
