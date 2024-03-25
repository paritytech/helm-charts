# Relaychain
## Install relaychain 
```shell
helm upgrade --install bootnode  . -f examples/local-rococo/bootnode.yaml
kubectl wait --for=condition=Ready pod bootnode-0 --timeout=90s
helm upgrade --install validators  . -f examples/local-rococo/validators-alice-bob.yaml

```

## Access to relaychain RPC
```shell
kubectl port-forward bootnode-0 9944:9944
```
open:  https://polkadot.js.org/apps/?rpc=ws%3A%2F%2F127.0.0.1%3A9944#/explorer

# Parachain
## Install parachain 
```shell
helm upgrade --install parachain  . -f examples/local-rococo/asset-hub.yaml
```

## Onboard parachain
1. Find the para_id and Genesis state
```shell
kubectl logs --tail 10 -f parachain-node-0 dump-state-and-wasm
# Parachain Id: 
#  "para_id": 1000,
# Genesis head:  
# 0x00000000000000000000000000000000000000000000000000000000000000000061dc4546910e4a874f59af705dd079344ecb7759f526cf86cf21db67473d0b4f03170a2e7597b7b7e3d84c05391d139a62b157e78786d8c082f29dcf4c11131400
```
2. Download genesis-wasm
```shell
kubectl cp parachain-node-0:/chain-data/genesis-wasm genesis-wasm
```
3. On relaychain RPC submit following call:
https://polkadot.js.org/apps/?rpc=ws%3A%2F%2F127.0.0.1%3A9944#/sudo
```shell
parasSudoWrapper.sudoScheduleParaInitialize(id, genesis)
id = 1000
genesisHead = 0x00000000000000000000000000000000000000000000000000000000000000000061dc4546910e4a874f59af705dd079344ecb7759f526cf86cf21db67473d0b4f03170a2e7597b7b7e3d84c05391d139a62b157e78786d8c082f29dcf4c11131400
validationCode = file upload(genesis-wasm)
paraKind = Yes
```
4. Check onboarding progress here: https://polkadot.js.org/apps/?rpc=ws%3A%2F%2F127.0.0.1%3A9944#/parachains/parathreads

## Access to parachain RPC
```shell
kubectl port-forward parachain-node-0 9945:9944
```
open:  https://polkadot.js.org/apps/?rpc=ws%3A%2F%2F127.0.0.1%3A9945#/explorer

## Cleanup
```shell
helm delete bootnode validators parachain
# clean pvc kubectl delete pvc --all
```