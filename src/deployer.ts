import { ethers } from "ethers";
const FACTORY = "0x4e59b44847b379578588920cA78FbF26c0B4956C";
export async function deployWithCreate2(bytecode: string, salt: string, wallet: ethers.Wallet): Promise<string> {
  const saltBytes = ethers.id(salt);
  const predictedAddress = ethers.getCreate2Address(FACTORY, saltBytes, ethers.keccak256(bytecode));
  console.log(`Deploying to predicted address: ${predictedAddress}`);
  const tx = await wallet.sendTransaction({ to: FACTORY, data: saltBytes + bytecode.slice(2) });
  await tx.wait();
  console.log(`Deployed! TX: ${tx.hash}`);
  return predictedAddress;
}
