## Example Rococo Local Chain
This example demonstrates deploying a Rococo-local (relaychain) test chain and parachain test chains in Kubernetes. 
The setup includes deploying one bootnode, two validators, and two parachain nodes via the Helm chart. 
Once both validators are running you will see block production. 
A custom chainspec is generated in the initcontainer on the bootnode, which is used to connect all relaychain nodes together.

### Relaychain Setup:
1. **Install the Relaychain:**
   
   Install the Helm charts for the bootnode and validators. Ensure that you have Helm installed and configured with the appropriate Kubernetes cluster.
   ```shell
   helm upgrade --install bootnode  . -f examples/local-rococo/bootnode.yaml
   kubectl wait --for=condition=Ready pod bootnode-0 --timeout=90s
   helm upgrade --install validators  . -f examples/local-rococo/validators-alice-bob.yaml
   ```

3. **Access Relaychain RPC:**
   
   Port-forward to access the relaychain RPC. This will allow you to interact with the relaychain using Polkadot.js apps or other tools.
   ```shell
   kubectl port-forward bootnode-0 9944:9944
   ```
   Open Polkadot.js apps at https://polkadot.js.org/apps/?rpc=ws%3A%2F%2F127.0.0.1%3A9944#/explorer to explore the relaychain.
   ![image](https://github.com/paritytech/helm-charts/assets/24387396/c6183545-b423-46f5-b376-f30bf3f2e5f6)


### Parachain Setup:
1. **Install the Parachain:**
   
   Install the Helm chart for the parachain. This will deploy the parachain nodes onto your Kubernetes cluster.
   ```shell
   helm upgrade --install parachain  . -f examples/local-rococo/parachain.yaml
   ```

2. **Onboard the Parachain:**
   - **Find Para_id and Genesis State:**
     
     Obtain the Para_id and genesisHead by checking the logs of the parachain node.
     ```shell
     kubectl logs --tail 10 -f parachain-node-0 dump-state-and-wasm
     # Parachain Id: 
     #  "para_id": 1000,
     # Genesis head:  
     # 0x00000000000000000000000000000000000000000000000000000000000000000061dc4546910e4a874f59af705dd079344ecb7759f526cf86cf21db67473d0b4f03170a2e7597b7b7e3d84c05391d139a62b157e78786d8c082f29dcf4c11131400
     ```
   - **Download Genesis-Wasm:**
     
     Copy the genesis-wasm file from the parachain node to your local machine.
     ```shell
     kubectl cp parachain-node-0:/chain-data/genesis-wasm genesis-wasm
     ```
   - **Execute `parasSudoWrapper.sudoScheduleParaInitialize(id, genesis)` on the Relaychain RPC.**
     
     Use [Polkadot.js](https://polkadot.js.org/apps/?rpc=ws%3A%2F%2F127.0.0.1%3A9944#/sudo) apps to submit a call to the relaychain RPC for onboarding the parachain.
     ![Screenshot from 2024-03-29 11-54-49](https://github.com/paritytech/helm-charts/assets/24387396/1c0a178e-f842-4cfa-97f7-22c08f40b2ce)

   - **Check Onboarding Progress:**
     
     Monitor the onboarding progress on Polkadot.js apps at https://polkadot.js.org/apps/?rpc=ws%3A%2F%2F127.0.0.1%3A9944#/parachains/parathreads.
     ![Screenshot from 2024-03-29 11-55-08](https://github.com/paritytech/helm-charts/assets/24387396/8de4849c-e212-4e61-a348-5bcab9cc32a6)
   - **Execute `slots.forceLease()` with**:
        * `para` : parachain ID
        * `amount` : eg `100`
        * `periodBegin` : numerical ID of the period at which to begin the lease,  in most cases, this should be set to the current period which is displayed as **current lease** in the parachain UI
        * `periodCount` : the number of lease periods for which the lease will be valid
     
     ![image](https://github.com/paritytech/helm-charts/assets/24387396/0e4362fa-4987-4b9e-a9a9-4709e476bb7c)


Note: If forceLease doesn't take effect. It's safe to trigger the call again

### Access Parachain RPC:
Port-forward to access the parachain RPC for interacting with the parachain node.
```shell
kubectl port-forward parachain-node-0 9945:9944
```
Open Polkadot.js apps at https://polkadot.js.org/apps/?rpc=ws%3A%2F%2F127.0.0.1%3A9945#/explorer to explore the parachain.
![image](https://github.com/paritytech/helm-charts/assets/24387396/cbf12f54-18b5-443c-892d-7632fe790b88)


### Cleanup:
Delete the Helm releases for bootnode, validators, and parachain. Optionally, clean up PVCs if necessary.
```shell
helm delete bootnode validators parachain
# Clean PVCs if needed
# kubectl delete pvc --all
```

### Advanced
Deploy parachain by using  `existingSecrets` option. 
1. Create secrets with node key(ID) and session keys. 
```shell
kubectl apply -f ./examples/local-rococo/secret.yaml
```
2. Deploy second parachain.
```
helm upgrade --install parachain2  . -f examples/local-rococo/parachain2.yaml
```
3. Onboard the parachain by following the previous steps.
