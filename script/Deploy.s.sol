// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "../contracts/Create2Factory.sol";

contract DeployScript is Script {
    // Standard CREATE2 factory (same on all EVM chains)
    address constant FACTORY = 0x4e59b44847b379578588920cA78FbF26c0B4956C;

    function run() external {
        uint256 deployerKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerKey);

        bytes32 salt = keccak256(abi.encodePacked("base-create2-factory-v1", block.chainid));
        bytes memory bytecode = type(Create2Factory).creationCode;

        // Compute address
        bytes32 bytecodeHash = keccak256(bytecode);
        address predicted = address(uint160(uint256(keccak256(abi.encodePacked(
            bytes1(0xff), FACTORY, salt, bytecodeHash
        )))));
        console.log("Predicted address:", predicted);

        // Deploy via standard factory
        (bool ok,) = FACTORY.call(abi.encodePacked(salt, bytecode));
        require(ok, "Deploy failed");
        console.log("Deployed to:", predicted);

        vm.stopBroadcast();
    }
}