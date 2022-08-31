# Substrate faucet helm chart

The helm chart installs the [Testnet Manager](https://github.com/paritytech/testnet-manager).

## Installing the chart

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