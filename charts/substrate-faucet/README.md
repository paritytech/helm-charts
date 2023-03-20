# Substrate faucet helm chart

The helm chart installs the [Substrate Matrix faucet](https://github.com/paritytech/substrate-matrix-faucet).

## Installing the chart

To deploy a Westend faucet:
```console
helm repo add parity https://paritytech.github.io/helm-charts/
helm install substrate-faucet parity/substrate-faucet \
    --set faucet.secret.SMF_BACKEND_FAUCET_ACCOUNT_MNEMONIC="//Alice" \
    --set faucet.secret.SMF_BOT_MATRIX_ACCESS_TOKEN="******" \
    --set faucet.config.SMF_BACKEND_RPC_ENDPOINT="https://westend-rpc.polkadot.io/" \
    --set faucet.config.SMF_BACKEND_INJECTED_TYPES='{}' \
    --set faucet.config.SMF_BACKEND_NETWORK_DECIMALS='12' \
    --set faucet.config.SMF_BOT_MATRIX_SERVER="https://matrix.org" \
    --set faucet.config.SMF_BOT_MATRIX_BOT_USER_ID="@test_bot_faucet:matrix.org" \
    --set faucet.config.SMF_BOT_NETWORK_UNIT="WND" \
    --set faucet.config.SMF_BOT_DRIP_AMOUNT="1"
```

## Parameters

### Global parameters

| Name                | Description                                | Value               |
| ------------------- | ------------------------------------------ | ------------------- |
| `image.repository`  | Image repository                           | `paritytech/faucet` |
| `image.tag`         | Image tag (immutable tags are recommended) | `latest`            |
| `image.pullPolicy`  | Image pull policy                          | `Always`            |
| `image.pullSecrets` | Image pull policy                          | `[]`                |


### Faucet parameters

| Name                                                | Description                                                                                             | Value                         |
| --------------------------------------------------- | ------------------------------------------------------------------------------------------------------- | ----------------------------- |
| `faucet.existingConfigMap`                          | existingConfigMap                                                                                       | `""`                          |
| `faucet.existingSecret`                             | existingSecret                                                                                          | `""`                          |
| `faucet.externalAccess`                             | externalAccess                                                                                          | `false`                       |
| `faucet.secret.SMF_BACKEND_FAUCET_ACCOUNT_MNEMONIC` | Mnemonic seed for the faucet account                                                                    | `this is a fake mnemonic`     |
| `faucet.secret.SMF_BACKEND_RECAPTCHA_SECRET`        | A secret recaptcha token used to validate external requests                                             | `fakeRecaptchaSecret`         |
| `faucet.secret.SMF_BOT_MATRIX_ACCESS_TOKEN`         | Matrix Bot access token                                                                                 | `ThisIsNotARealAccessToken`   |
| `faucet.config.SMF_BACKEND_RPC_ENDPOINT`            | WS RPC node endpoint                                                                                    | `https://example.com/`        |
| `faucet.config.SMF_BACKEND_NETWORK_DECIMALS`        | Number of decimal for the network                                                                       | `12`                          |
| `faucet.config.SMF_BACKEND_INJECTED_TYPES`          | To set if any type must be overriden                                                                    | `{}`                          |
| `faucet.config.SMF_BOT_DRIP_AMOUNT`                 | Default amount of tokens to send                                                                        | `10`                          |
| `faucet.config.SMF_BOT_MATRIX_SERVER`               | Matrix server URL                                                                                       | `https://matrix.org`          |
| `faucet.config.SMF_BOT_MATRIX_BOT_USER_ID`          | Bot user ID                                                                                             | `@test_bot_faucet:matrix.org` |
| `faucet.config.SMF_BOT_NETWORK_UNIT`                | Token unit for the network                                                                              | `UNIT`                        |
| `faucet.config.SMF_BOT_FAUCET_IGNORE_LIST`          | A list of Matrix accounts that will be silently ignored. Example: \"@alice:matrix.org,@bob:domain.com\" | `""`                          |


### Common parameters

| Name                           | Description                                                                          | Value   |
| ------------------------------ | ------------------------------------------------------------------------------------ | ------- |
| `replicaCount`                 | Number of replicas pods for the faucet (recommended to keep it at 1)                 | `1`     |
| `extraLabels`                  | Labels to add to all deployed objects                                                | `[]`    |
| `nameOverride`                 | String to partially override common.names.name                                       | `""`    |
| `fullnameOverride`             | String to fully override common.names.fullname                                       | `""`    |
| `serviceAccount.create`        | Specifies whether a ServiceAccount should be created                                 | `true`  |
| `serviceAccount.name`          | The name of the ServiceAccount to use.                                               | `""`    |
| `podSecurityContext`           | Set pods' Security Context                                                           | `{}`    |
| `resources.limits`             | The resources limits for containers                                                  | `{}`    |
| `resources.requests`           | The requested resources for containers                                               | `{}`    |
| `nodeSelector`                 | Node labels for pods assignment                                                      | `{}`    |
| `tolerations`                  | Tolerations for pods assignment                                                      | `[]`    |
| `affinity`                     | Affinity for pods assignment                                                         | `{}`    |
| `serviceMonitor.enabled`       | Specifies whether a ServiceMonitor should be created                                 | `false` |
| `serviceMonitor.interval`      | Duration between scrapes of the target endpoint                                      | `1m`    |
| `serviceMonitor.scrapeTimeout` | Timeout for each scrape request                                                      | `30s`   |
| `serviceMonitor.targetLabels`  | List of target labels to be added to all metrics collected from this service monitor | `[]`    |
| `ingress.enabled`              | Specifies whether as Ingress should be created                                       | `false` |
