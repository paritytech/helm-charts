<!--
DO NOT EDIT README.md manually!
We're using [helm-docs](https://github.com/norwoodj/helm-docs) to render values of the chart.
If you updated values.yaml file make sure to render a new README.md locally before submitting a Pull Request.

If you're using [pre-commit](https://pre-commit.com/) make sure to install the hooks first:
```
pre-commit install
```
REAMDE.md will be updating automatically after that.

Otherwise, you should install helm-docs and manually update README.md. Navigate to repository root and run:
`helm-docs --chart-search-root=charts/substrate-faucet --template-files=README.md.gotmpl`

You may encounter `files were modified by this hook` error after updating README.md.gotmpl file when using pre-commit.
This is intended behaviour. Make sure to run `git add -A` once again to stage changes in the auto-updated REAMDE.md
-->

# Substrate faucet Helm chart

![Version: 3.0.3](https://img.shields.io/badge/Version-3.0.3-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| Parity | <devops+helm@parity.io> | <https://github.com/paritytech/helm-charts> |

The helm chart installs the [Substrate Matrix faucet](https://github.com/paritytech/substrate-matrix-faucet).

## Installing the chart

To deploy a Westend faucet:
```console
helm repo add parity https://paritytech.github.io/helm-charts/
helm dependency update
helm install substrate-faucet parity/substrate-faucet \
    --set faucet.secret.SMF_CONFIG_FAUCET_ACCOUNT_MNEMONIC="//Alice" \
    --set faucet.secret.SMF_CONFIG_MATRIX_ACCESS_TOKEN="******" \
    --set faucet.config.SMF_CONFIG_MATRIX_SERVER="https://matrix.org" \
    --set faucet.config.SMF_CONFIG_MATRIX_BOT_USER_ID="@test_bot_faucet:matrix.org" \
    --set faucet.config.SMF_CONFIG_NETWORK="westend"
```

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

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://charts.bitnami.com/bitnami | postgresql | 12.8.3 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` | Affinity for pods assignment ref: https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#affinity-and-anti-affinity |
| extraLabels | list | `[]` | Labels to add to all deployed objects |
| faucet | object | `{"config":{"SMF_CONFIG_FAUCET_IGNORE_LIST":"","SMF_CONFIG_MATRIX_BOT_USER_ID":"@test_bot_faucet:matrix.org","SMF_CONFIG_MATRIX_SERVER":"https://matrix.org","SMF_CONFIG_NETWORK":"rococo"},"existingConfigMap":"","existingSecret":"","externalAccess":false,"secret":{"SMF_CONFIG_FAUCET_ACCOUNT_MNEMONIC":"this is a fake mnemonic","SMF_CONFIG_MATRIX_ACCESS_TOKEN":"ThisIsNotARealAccessToken","SMF_CONFIG_RECAPTCHA_SECRET":"fakeRecaptchaSecret"}}` | Faucet parameters |
| faucet.config.SMF_CONFIG_FAUCET_IGNORE_LIST | string | `""` | A list of Matrix accounts that will be silently ignored. Example: \"@alice:matrix.org,@bob:domain.com\" |
| faucet.config.SMF_CONFIG_MATRIX_BOT_USER_ID | string | `"@test_bot_faucet:matrix.org"` | Bot user ID |
| faucet.config.SMF_CONFIG_MATRIX_SERVER | string | `"https://matrix.org"` | Matrix server URL |
| faucet.config.SMF_CONFIG_NETWORK | string | `"rococo"` | network name: rococo, westend, wococo, etc. |
| faucet.existingConfigMap | string | `""` | existingConfigMap |
| faucet.existingSecret | string | `""` | existingSecret |
| faucet.externalAccess | bool | `false` | externalAccess |
| faucet.secret.SMF_CONFIG_FAUCET_ACCOUNT_MNEMONIC | string | `"this is a fake mnemonic"` | Mnemonic seed for the faucet account |
| faucet.secret.SMF_CONFIG_MATRIX_ACCESS_TOKEN | string | `"ThisIsNotARealAccessToken"` | Matrix Bot access token |
| faucet.secret.SMF_CONFIG_RECAPTCHA_SECRET | string | `"fakeRecaptchaSecret"` | A secret recaptcha token used to validate external requests |
| fullnameOverride | string | `""` | String to fully override common.names.fullname |
| image | object | `{"pullPolicy":"Always","pullSecrets":[],"repository":"paritytech/faucet","tag":"latest"}` | Docker image parameters |
| image.pullPolicy | string | `"Always"` | Image pull policy |
| image.pullSecrets | list | `[]` | Image pull policy |
| image.repository | string | `"paritytech/faucet"` | Image repository |
| image.tag | string | `"latest"` | Image tag (immutable tags are recommended) |
| ingress | object | `{"enabled":false}` | Ingress configuration |
| ingress.enabled | bool | `false` | Specifies whether as Ingress should be created |
| nameOverride | string | `""` | String to partially override common.names.name |
| nodeSelector | object | `{}` | Node labels for pods assignment ref: https://kubernetes.io/docs/user-guide/node-selection/ |
| podSecurityContext | object | `{}` | Pods Security Context ref: https://kubernetes.io/docs/tasks/configure-pod-container/security-context/#set-the-security-context-for-a-pod |
| postgresql | object | `{"global":{"postgresql":{"auth":{"database":"faucet","postgresPassword":"Secret!"}}},"primary":{"persistence":{"size":"4Gi"},"resources":{"limits":{"memory":"1024Mi"},"requests":{"cpu":"250m","memory":"512Mi"}}}}` | PostgreSQL configuration |
| postgresql.global.postgresql.auth | object | `{"database":"faucet","postgresPassword":"Secret!"}` | Auth configuration |
| postgresql.global.postgresql.auth.database | string | `"faucet"` | Database name |
| postgresql.global.postgresql.auth.postgresPassword | string | `"Secret!"` | Database password |
| postgresql.primary | object | `{"persistence":{"size":"4Gi"},"resources":{"limits":{"memory":"1024Mi"},"requests":{"cpu":"250m","memory":"512Mi"}}}` | Primary PostgreSQL configuration |
| postgresql.primary.persistence | object | `{"size":"4Gi"}` | Storage configuration |
| postgresql.primary.persistence.size | string | `"4Gi"` | Storage size |
| postgresql.primary.resources | object | `{"limits":{"memory":"1024Mi"},"requests":{"cpu":"250m","memory":"512Mi"}}` | Resources requests/limits for the container |
| postgresql.primary.resources.limits.memory | string | `"1024Mi"` | Memory limit |
| postgresql.primary.resources.requests.cpu | string | `"250m"` | CPU requests |
| postgresql.primary.resources.requests.memory | string | `"512Mi"` | Memory requests |
| replicaCount | int | `1` | Number of replicas pods for the faucet (recommended to keep it at 1) |
| resources | object | `{"limits":{},"requests":{}}` | Resource requests and limits ref: http://kubernetes.io/docs/user-guide/compute-resources/ |
| resources.limits | object | `{}` | The resources limits for containers |
| resources.requests | object | `{}` | The requested resources for containers |
| serviceAccount | object | `{"create":true,"name":""}` | ServiceAccount configuration |
| serviceAccount.create | bool | `true` | Specifies whether a ServiceAccount should be created |
| serviceAccount.name | string | `""` | The name of the ServiceAccount to use. If not set and create is true, a name is generated using the common.names.fullname template |
| serviceMonitor | object | `{"enabled":false,"interval":"1m","scrapeTimeout":"30s","targetLabels":[]}` | ServiceMonitor configuration |
| serviceMonitor.enabled | bool | `false` | Specifies whether a ServiceMonitor should be created |
| serviceMonitor.interval | string | `"1m"` | Duration between scrapes of the target endpoint |
| serviceMonitor.scrapeTimeout | string | `"30s"` | Timeout for each scrape request |
| serviceMonitor.targetLabels | list | `[]` | List of target labels to be added to all metrics collected from this service monitor |
| tolerations | list | `[]` | Tolerations for pods assignment ref: https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/ |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.12.0](https://github.com/norwoodj/helm-docs/releases/v1.12.0)
