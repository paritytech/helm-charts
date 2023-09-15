Test the following node modes:
- Validator
- RPC
- Full
- Bootnode

Test scenarios:
- a node is running in `--dev` mode along with `ws-exporter`` sidecar and posting a healthy status (relay chain + para chain)
- backup restoration works. Need to mock it somehow, restoring full backup is not feasible. Possibly, serve a small backup for a custom chain from the local HTTP server spun up within the same test suite
- RPC node (2 replicas) is publicly exposed through the LB and serves RPC queries
- a Bootnode can bootstrap other nodes on the network
- a Validator nodes produce blocks (possible with `--dev` flag?)
- can load keys from Vault
- Pods are reachable through Services (p2p, rpc)
- can download custom chainspec
- can download custom runtime
- generated node key are persisted
- can inject keys
