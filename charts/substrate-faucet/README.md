# Substrate faucet helm chart

The helm chart installs the [Substrate Matrix faucet](https://github.com/paritytech/substrate-matrix-faucet).

## Installing the chart

To deploy a Westend faucet:
```console
helm repo add parity https://paritytech.github.io/helm-charts/
helm install substrate-faucet parity/substrate-faucet \
    --set faucet.secret.SMF_CONFIG_FAUCET_ACCOUNT_MNEMONIC="//Alice" \
    --set faucet.secret.SMF_CONFIG_MATRIX_ACCESS_TOKEN="******" \
    --set faucet.config.SMF_CONFIG_MATRIX_SERVER="https://matrix.org" \
    --set faucet.config.SMF_CONFIG_MATRIX_BOT_USER_ID="@test_bot_faucet:matrix.org" 
    --set faucet.config.SMF_CONFIG_NETWORK="westend" 
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

| Name                                               | Description                                                                                             | Value                         |
|----------------------------------------------------|---------------------------------------------------------------------------------------------------------|-------------------------------|
| `faucet.existingConfigMap`                         | existingConfigMap                                                                                       | `""`                          |
| `faucet.existingSecret`                            | existingSecret                                                                                          | `""`                          |
| `faucet.externalAccess`                            | externalAccess                                                                                          | `false`                       |
| `faucet.secret.SMF_CONFIG_FAUCET_ACCOUNT_MNEMONIC` | Mnemonic seed for the faucet account                                                                    | `this is a fake mnemonic`     |
| `faucet.secret.SMF_CONFIG_RECAPTCHA_SECRET`        | A secret recaptcha token used to validate external requests                                             | `fakeRecaptchaSecret`         |
| `faucet.secret.SMF_CONFIG_MATRIX_ACCESS_TOKEN`     | Matrix Bot access token                                                                                 | `ThisIsNotARealAccessToken`   |
| `faucet.config.SMF_CONFIG_NETWORK`                 | Name of the network; matches corresponding config in the code                                           | `rococo`                      |
| `faucet.config.SMF_CONFIG_MATRIX_SERVER`           | Matrix server URL                                                                                       | `https://matrix.org`          |
| `faucet.config.SMF_CONFIG_MATRIX_BOT_USER_ID`      | Bot user ID                                                                                             | `@test_bot_faucet:matrix.org` |
| `faucet.config.SMF_CONFIG_FAUCET_IGNORE_LIST`      | A list of Matrix accounts that will be silently ignored. Example: \"@alice:matrix.org,@bob:domain.com\" | `""`                          |


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



### How to create a matrix bot account

  - go to https://app.element.io/#/welcome
  - create account
  - pickup username and pass
  - set an email used to create the bot account

### How to get matrix API access token

To create a Matrix access token for your user, follow instructions on the [matrix.org Client Server API guide] (https://matrix.org/docs/guides/client-server-api#login).
create a script called `get_matrix_api_access_token.sh`
```bash
cat get_matrix_api_access_token.sh 
#!/bin/bash

# script based on https://www.matrix.org/docs/guides/client-server-api#login

# you need first to export MATRIX_USER and MATRIX_PASS values in your shell
# get values from 1password/SRE/composablefi_faucet matrix bot

# export MATRIX_USER=
# export MATRIX_PASS=

cat <<EOF | curl -X POST \
  https://matrix.org/_matrix/client/r0/login \
  -H "Content-Type: application/json" \
  --data-binary @-
{
  "type": "m.login.password",
  "identifier": {
    "type": "m.id.user",
    "user": "${MATRIX_USER}"
  },
  "password": "${MATRIX_PASS}"
}
EOF
```


```bash
# you need first to export MATRIX_USER and MATRIX_PASS values in your shell
# get values from 1password/SRE/composablefi_faucet matrix bot

# export MATRIX_USER=
# export MATRIX_PASS=
./get_matrix_api_access_token.sh
```
https://spec.matrix.org/latest/client-server-api/

https://www.matrix.org/docs/guides/client-server-api 

### How to use the faucet

Once deployed, you would want to test the faucet.

  - Create a matrix bot account on your matrix server and login using the element web app
https://app.element.io/#/room/#test_bot_faucet:matrix.org
  - while logged in as  the bot, use the UI to create a new public room
  - with a new matrix user, join the room
  - set up an account ready to receive tokens on your chain and send this message command:
```
!drip 5vFiJ56meRz883MRPkK2TnigBKCAr99x9DZUMotwTBLBmEM3
```
The bot should respond:

    Sent @user:matrix.org 1 UNIT. Extrinsic hash:
    0xffaf7fc6ddda98c2467658527b39c9e775b7e02dd76cd139ff183090659fd7c4



#####  How logs should look like for a successful deployment and token transfer
```
kubectl logs substrate-faucet-856cc5b498-29nt5 -f
yarn run v1.22.5
$ node ./build/src/start.js
2023-03-31 18:19:31        API/INIT: Api will be available in a limited mode since the provider does not support subscriptions
[2023-03-31T18:19:31.592] [INFO] default - 🚰 Plip plop - Creating the faucets's account
[2023-03-31T18:19:31.597] [INFO] default - Ignore list: (1 entries)
[2023-03-31T18:19:31.597] [INFO] default -  ''
SMF:
  📦 BOT:
     ✅ BACKEND_URL: "http://localhost:5555"
     ✅ DRIP_AMOUNT: 100
     ✅ MATRIX_ACCESS_TOKEN: *****
     ✅ MATRIX_BOT_USER_ID: "@composablefi_faucet:matrix.org"
     ✅ MATRIX_SERVER: "https://matrix.org"
     ✅ NETWORK_DECIMALS: 12
     ✅ NETWORK_UNIT: "PICA"
     ✅ FAUCET_IGNORE_LIST: ""
     ✅ DEPLOYED_REF: "unset"
     ✅ DEPLOYED_TIME: "unset"
[2023-03-31T18:19:31.850] [INFO] default - ✅ BOT config validated
SMF:
  📦 BACKEND:
     ✅ FAUCET_ACCOUNT_MNEMONIC: *****
     ✅ FAUCET_BALANCE_CAP: 100
     ✅ INJECTED_TYPES: "[]"
     ✅ NETWORK_DECIMALS: 12
     ✅ PORT: 5555
     ✅ RPC_ENDPOINT: "https://picasso-rococo-rpc-lb.composablenodes.tech/"
     ✅ DEPLOYED_REF: "paritytech/faucet:latest"
     ✅ DEPLOYED_TIME: "2023-03-31T18:18:58"
     ✅ EXTERNAL_ACCESS: false
     ✅ DRIP_AMOUNT: "0.5"
     ✅ RECAPTCHA_SECRET: *****
[2023-03-31T18:19:31.932] [INFO] default - ✅ BACKEND config validated
[2023-03-31T18:19:32.069] [INFO] default - Starting faucet v1.1.2
[2023-03-31T18:19:32.069] [INFO] default - Faucet backend listening on port 5555.
[2023-03-31T18:19:32.069] [INFO] default - Using @polkadot/api 10.0.1
Connected to the in-memory SQlite database.
Getting saved sync token...
Getting push rules...
Attempting to send queued to-device messages
Got saved sync token
Got reply from saved sync, exists? false
All queued to-device messages sent
Got push rules
Adding default global override for .org.matrix.msc3786.rule.room.server_acl
Checking lazy load status...
Checking whether lazy loading has changed in store...
Storing client options...
Stored client options
Getting filter...
[2023-03-31T18:19:34.975] [INFO] default - Fetched faucet balance 💰
Sending initial sync request...
Waiting for saved sync before starting sync processing...
Adding default global override for .org.matrix.msc3786.rule.room.server_acl
[2023-03-31T18:22:50.364] [DEBUG] default - Processing request from @radupopa:matrix.org
[2023-03-31T18:22:50.365] [DEBUG] default - Processed receiver to address 5vFiJ56meRz883MRPkK2TnigBKCAr99x9DZUMotwTBLBmEM3 and parachain id 
[2023-03-31T18:22:50.465] [INFO] default - 💸 sending tokens
[2023-03-31T18:22:51.196] [INFO] default - Refreshed the faucet balance 💰
```
