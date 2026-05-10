// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title Create2Factory — Deterministic deployment factory for Base L2
contract Create2Factory {
    event Deployed(address indexed deployed, bytes32 indexed salt);

    /// @notice Deploy a contract using CREATE2
    function deploy(bytes32 salt, bytes memory bytecode) external returns (address deployed) {
        assembly {
            deployed := create2(0, add(bytecode, 0x20), mload(bytecode), salt)
        }
        require(deployed != address(0), "Deployment failed");
        emit Deployed(deployed, salt);
    }

    /// @notice Compute the CREATE2 address without deploying
    function computeAddress(bytes32 salt, bytes32 bytecodeHash) external view returns (address) {
        return address(uint160(uint256(keccak256(abi.encodePacked(
            bytes1(0xff), address(this), salt, bytecodeHash
        )))));
    }

    /// @notice Deploy with initialization call
    function deployAndInit(bytes32 salt, bytes memory bytecode, bytes memory initData)
        external returns (address deployed) {
        assembly {
            deployed := create2(0, add(bytecode, 0x20), mload(bytecode), salt)
        }
        require(deployed != address(0), "Deployment failed");
        if (initData.length > 0) {
            (bool ok,) = deployed.call(initData);
            require(ok, "Init failed");
        }
        emit Deployed(deployed, salt);
    }
}