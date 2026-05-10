# base-deploy-factory

> Smart Contract Deployment Factory for Base L2

Deterministic CREATE2 deployments, upgradeable proxy patterns, and multi-chain deployment scripts optimized for Base L2. Deploy the same contract address across all OP Stack chains.

## Features
- 🏭 CREATE2 factory for deterministic addresses
- 🔄 UUPS & Transparent proxy deployments
- ⛓️ Multi-chain deployment (Base + OP Stack chains)
- 📜 Foundry + Hardhat deployment scripts
- 🔑 Safe multisig deployment support
- ✅ Automated contract verification (Basescan)
- 📝 Deployment registry (JSON)

## Address Determinism

With CREATE2, you can compute the deployment address before deploying:
```typescript
import { getCreate2Address } from "./src/factory";

const { address } = getCreate2Address({
  factory: CREATE2_FACTORY,
  deployer: myAddress,
  salt: ethers.id("my-contract-v1"),
  bytecode: MyContract__factory.bytecode,
});
console.log("Will deploy to:", address);
```

## Deployment Scripts
```bash
# Deploy with CREATE2 (same address on all chains)
forge script script/DeployCreate2.s.sol \
  --rpc-url $BASE_RPC_URL --broadcast --verify

# Deploy upgradeable proxy
forge script script/DeployProxy.s.sol \
  --rpc-url $BASE_RPC_URL --broadcast --verify
```

## CREATE2 Factory (Base)
`0x4e59b44847b379578588920cA78FbF26c0B4956C` (standard)

## License
MIT