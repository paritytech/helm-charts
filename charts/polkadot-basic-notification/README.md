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
`helm-docs --chart-search-root=charts/polkadot-basic-notification --template-files=README.md.gotmpl`

You may encounter `files were modified by this hook` error after updating README.md.gotmpl file when using pre-commit.
This is intended behaviour. Make sure to run `git add -A` once again to stage changes in the auto-updated REAMDE.md
-->

# Polkadot basic notification helm chart

The helm chart installs the [Polkadot-basic-notification service](https://github.com/paritytech/polkadot-basic-notification).

![Version: 1.0.3](https://img.shields.io/badge/Version-1.0.3-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.1.0](https://img.shields.io/badge/AppVersion-0.1.0-informational?style=flat-square)

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| Parity | <devops+helm@parity.io> | <https://github.com/paritytech/helm-charts> |

## Installing the chart

```console
helm repo add parity https://paritytech.github.io/helm-charts/
helm install polkadot-basic-notification parity/polkadot-basic-notification
```

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` | Assign custom affinity rules |
| config | object | `{"configFiles":["accounts:\n  - address: \"SS85 ADDRESS HERE\"\n    label: \"This is the label for the 1st account\"\n  - address: \"SS85 ADDRESS HERE\"\n    label: \"This is the label for the 2nd account\"\nendpoints:\n  - \"wss://westend-rpc.polkadot.io\"\n  - \"wss://rococo-rpc.polkadot.io\"\nextrinsicFilter: []\neventFilter:\n  - \"system.CodeUpdated\"\n  - \"democracy.Passed\"\n  - \"imonline.SomeOffline\"\nreporters:\n  console: true\n  matrix:\n    userId: \"Pass via MATRIX_USERID env variable secret\"\n    accessToken: \"Pass via MATRIX_ACCESSTOKEN env variable secret\"\n    roomId: \"!1234example4321:matrix.parity.io\"\n    server: \"https://matrix.parity.io\"\n"],"secret":{"MATRIX_ACCESSTOKEN":"","MATRIX_USERID":"","existingSecret":""}}` | polkadot-basic-notification configuration See https://github.com/paritytech/polkadot-basic-notification for the details |
| config.secret | object | `{"MATRIX_ACCESSTOKEN":"","MATRIX_USERID":"","existingSecret":""}` | Set configuratio variables as a Secret |
| config.secret.MATRIX_ACCESSTOKEN | string | `""` | Access token for the Matrix server |
| config.secret.MATRIX_USERID | string | `""` | User ID for the Matrix server |
| config.secret.existingSecret | string | `""` | A name of the existing secret with MATRIX_ACCESSTOKEN and MATRIX_USERID. See secrets.yaml |
| env | object | `{}` | Environment variables to set on the main container |
| envFrom | list | `[]` | Environment variables to set on the main container from a ConfigMap or a Secret |
| fullnameOverride | string | `""` | Provide a name to substitute for the full names of resources |
| image | object | `{"pullPolicy":"Always","repository":"paritytech/polkadot-basic-notification","tag":"latest"}` | Image of the main container |
| image.pullPolicy | string | `"Always"` | Image pull policy |
| image.repository | string | `"paritytech/polkadot-basic-notification"` | Image repository |
| image.tag | string | `"latest"` | Image tag |
| imagePullSecrets | list | `[]` | Reference to one or more secrets to be used when pulling images. ref: https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/ |
| nameOverride | string | `""` | Provide a name in place of node for `app:` labels |
| nodeSelector | object | `{}` | Define which Nodes the Pods are scheduled on |
| podAnnotations | object | `{}` | Annotations to assign to the Pods |
| podSecurityContext | object | `{}` | SecurityContext holds pod-level security attributes and common container settings. ref: https://kubernetes.io/docs/tasks/configure-pod-container/security-context/ |
| resources | object | `{}` | Resource limits & requests |
| securityContext | object | `{}` | SecurityContext settings for the main container |
| serviceAccount | object | `{"annotations":{},"create":true,"name":""}` | Service account to use. |
| serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| serviceAccount.name | string | `""` | The name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| serviceMonitor | object | `{"annotations":{},"enabled":false,"endpoints":[{"honorLabels":true,"interval":"1m","path":"/metrics","port":"http","scheme":"http","scrapeTimeout":"30s"}]}` | Service Monitor of Prometheus-Operator ref: https://github.com/prometheus-operator/prometheus-operator/blob/main/Documentation/user-guides/getting-started.md#include-servicemonitors |
| serviceMonitor.annotations | object | `{}` | Annotations to assign to the ServiceMonitor |
| serviceMonitor.enabled | bool | `false` | Enables Service Monitor |
| serviceMonitor.endpoints | list | `[{"honorLabels":true,"interval":"1m","path":"/metrics","port":"http","scheme":"http","scrapeTimeout":"30s"}]` | List of endpoints of service which Prometheus scrapes |
| tolerations | list | `[]` | Tolerations for use with node taints |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.11.0](https://github.com/norwoodj/helm-docs/releases/v1.11.0)
