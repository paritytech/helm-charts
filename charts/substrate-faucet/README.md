# Substrate faucet helm chart

The helm chart installs the [Substrate Matrix faucet](https://github.com/paritytech/substrate-matrix-faucet).

## Installing the chart

To deploy a Westend faucet:
```console
helm repo add parity https://paritytech.github.io/helm-charts/
helm install substrate-faucet parity/substrate-faucet \
    --set node.chain="westend" \
    --set server.secret.SMF_BACKEND_FAUCET_ACCOUNT_MNEMONIC="//Alice" \
    --set server.config.SMF_BACKEND_RPC_ENDPOINT="https://westend-rpc.polkadot.io/" \
    --set server.config.SMF_BACKEND_INJECTED_TYPES='{}' \
    --set server.config.SMF_BACKEND_PORT=5555 \
    --set bot.secret.SMF_BOT_MATRIX_ACCESS_TOKEN="******" \
    --set bot.config.SMF_BOT_MATRIX_SERVER="https://matrix.org" \
    --set bot.config.SMF_BOT_MATRIX_BOT_USER_ID="@test_bot_faucet:matrix.org" \
    --set bot.config.SMF_BOT_NETWORK_UNIT="WND" \
    --set bot.config.SMF_BOT_DRIP_AMOUNT="0.1"
```

## Parameters

### Common parameters

| Parameter            | Description                                | Default                        |
|----------------------|--------------------------------------------|--------------------------------|
| `imagePullSecrets`   | Labels to add to all deployed objects      | `[]`                           |
| `nameOverride`       | String to partially override node.fullname | `nil`                          |
| `fullnameOverride`   | String to fully override node.fullname     | `nil`                          |
| `podSecurityContext` | Specify the pod security settings          | `{}`                           |  
| `resources`          | Resources to set on pods                   | `{}`                           |  
| `nodeSelector`       | Node labels for pod assignment             | `{}`                           |  
| `tolerations`        | Tolerations for pod assignment             | `[]`                           |  
| `affinity`           | Affinity for pod assignment                | `{}`                           |  

### Substrate-faucet parameters

| Parameter                 | Description                                                                  | Default     |
|---------------------------|------------------------------------------------------------------------------|-------------|
| `chain.name`              | Chain name                                                                   | `substrate` |
| `replicaCount`            | Number of replicas for the bot and server pods (recommended to keep it at 1) | `1`         |
| `server.image.repository` | Server image repository                                                      | `9615`      |
| `server.image.tag`        | Server image tag                                                             | `9615`      |
| `server.image.pullPolicy` | Server image pull policy                                                     | `9615`      |
| `server.secret`           | Server secret environment variable map                                       | `{}`        |
| `server.config`           | Server config environment variable map                                       | `{}`        |
| `bot.image.repository`    | Bot image repository                                                         | `9615`      |
| `bot.image.tag`           | Bot image tag                                                                | `9615`      |
| `bot.image.pullPolicy`    | Bot image pull policy                                                        | `9615`      |
| `bot.secret`              | Bot secret environment variable map                                          | `9615`      |
| `bot.config`              | Bot config environment variable map                                          | `9615`      |
