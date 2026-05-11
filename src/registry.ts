import * as fs from "fs";
interface DeploymentRecord { name: string; address: string; chainId: number; txHash: string; timestamp: string; }
const REGISTRY_FILE = "deployments.json";
export function recordDeployment(record: DeploymentRecord) {
  let registry: DeploymentRecord[] = [];
  if (fs.existsSync(REGISTRY_FILE)) registry = JSON.parse(fs.readFileSync(REGISTRY_FILE, "utf8"));
  registry.push(record);
  fs.writeFileSync(REGISTRY_FILE, JSON.stringify(registry, null, 2));
  console.log(`Recorded deployment of ${record.name} at ${record.address}`);
}
export function getDeployment(name: string, chainId: number): DeploymentRecord | undefined {
  if (!fs.existsSync(REGISTRY_FILE)) return undefined;
  const registry: DeploymentRecord[] = JSON.parse(fs.readFileSync(REGISTRY_FILE, "utf8"));
  return registry.find(r => r.name === name && r.chainId === chainId);
}
