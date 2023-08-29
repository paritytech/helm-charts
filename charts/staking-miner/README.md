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
`helm-docs --chart-search-root=charts/staking-miner --template-files=README.md.gotmpl`

You may encounter `files were modified by this hook` error after updating README.md.gotmpl file when using pre-commit.
This is intended behaviour. Make sure to run `git add -A` once again to stage changes in the auto-updated REAMDE.md
-->

# Staking Miner Helm Chart

![Version: 2.0.0](https://img.shields.io/badge/Version-2.0.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| Parity | <devops+helm@parity.io> | <https://github.com/paritytech/helm-charts> |

## TL;DR

```console
$ helm repo add bitnami https://charts.bitnami.com/bitnami
$ helm repo add parity https://paritytech.github.io/helm-charts/
$ helm dependency build
$ helm install staking-miner parity/staking-miner
```

## Introduction

A Helm chart for [staking-miner](https://github.com/paritytech/staking-miner)

## Prerequisites

- Kubernetes 1.19+
- Helm 3.2.0+

## Installing the Chart

To install the chart with the release name `staking-miner`:

```console
helm install staking-miner parity/staking-miner
```

The command deploys staking-miner on the Kubernetes cluster in the default configuration. The [Parameters](#parameters) section lists the parameters that can be configured during installation.

> **Tip**: List all releases using `helm list`

## Uninstalling the Chart

To uninstall/delete the `staking-miner` deployment:

```console
helm delete staking-miner
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

> **NOTE**: The Helm chart uses [readme-generator](https://github.com/bitnami-labs/readme-generator-for-helm) to generate [Parameters](#parameters) section. Make sure to update the parameters with that tool instead of manually editing it.

## Upgrading

### ⚠️ 2.0.0 (breaking change)
Values for `waitRuntimeUpgrade` have changed

Before:
```
waitRuntimeUpgrade: true
```

Now:
```
waitRuntimeUpgrade:
  enabled: true
  resources: {}
```

### ⚠️ 1.1.0 (breaking change)
Chart version 1.1.0 has breaking changes. staking-miner CLI [has changed](https://github.com/paritytech/polkadot/pull/5577) the order of positional arguments.

Before:
```
staking-miner --seed-or-path <foo> monitor|dry-run
```

Now:
```
staking-miner monitor|dry-run --seed-or-path <foo>
```

If you use a customized value for `args` make sure to update it accordingly. If you use `args` as is you don't have to do anything.

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://charts.bitnami.com/bitnami | common | 1.14.1 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` | Affinity for staking-miner pods assignment ref: https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#affinity-and-anti-affinity NOTE: `podAffinityPreset`, `podAntiAffinityPreset`, and `nodeAffinityPreset` will be ignored when it's set |
| args | list | `["-c","staking-miner monitor --seed-or-path /config/seed --uri $(cat /config/uri) seq-phragmen\n"]` | Override default container args (useful when using custom images) |
| clusterDomain | string | `"cluster.local"` | Kubernetes cluster domain name |
| command | list | `["/bin/sh"]` | Override default container command (useful when using custom images) |
| commonAnnotations | object | `{}` | Annotations to add to all deployed objects |
| commonLabels | object | `{}` | Labels to add to all deployed objects |
| containerSecurityContext | object | `{"enabled":true,"readOnlyRootFilesystem":false,"runAsNonRoot":true,"runAsUser":1001}` | Configure Container Security Context ref: https://kubernetes.io/docs/tasks/configure-pod-container/security-context/#set-the-security-context-for-a-container |
| containerSecurityContext.enabled | bool | `true` | Enable staking-miner containers' Security Context |
| containerSecurityContext.readOnlyRootFilesystem | bool | `false` | Set staking-miner containers' Security Context readOnlyRootFilesystem |
| containerSecurityContext.runAsNonRoot | bool | `true` | Set staking-miner containers' Security Context runAsNonRoot |
| containerSecurityContext.runAsUser | int | `1001` | Set staking-miner containers' Security Context runAsUser |
| customLivenessProbe | object | `{}` | Custom livenessProbe that overrides the default one |
| customReadinessProbe | object | `{}` | Custom readinessProbe that overrides the default one |
| customStartupProbe | object | `{}` | Custom startupProbe that overrides the default one |
| diagnosticMode | object | `{"args":["infinity"],"command":["sleep"],"enabled":false}` | Enable diagnostic mode in the deployment |
| diagnosticMode.args | list | `["infinity"]` | Args to override all containers in the deployment |
| diagnosticMode.command | list | `["sleep"]` | Command to override all containers in the deployment |
| diagnosticMode.enabled | bool | `false` | Enable diagnostic mode (all probes will be disabled and the command will be overridden) |
| extraDeploy | list | `[]` | Array of extra objects to deploy with the release |
| extraEnvVars | list | `[]` | Array with extra environment variables to add to staking-miner nodes e.g: extraEnvVars:   - name: FOO     value: "bar" |
| extraEnvVarsCM | string | `""` | Name of existing ConfigMap containing extra env vars for staking-miner nodes |
| extraEnvVarsSecret | string | `""` | Name of existing Secret containing extra env vars for staking-miner nodes |
| extraVolumeMounts | list | `[]` | Optionally specify extra list of additional volumeMounts for the staking-miner container(s) |
| extraVolumes | list | `[]` | Optionally specify extra list of additional volumes for the staking-miner pod(s) |
| fullnameOverride | string | `""` | Provide a name to substitute for the full names of resources |
| generateConfig | object | `{"image":{"pullPolicy":"IfNotPresent","pullSecrets":[],"registry":"docker.io","repository":"paritytech/tools","tag":"latest"},"resources":{}}` | Parameters for init container that generates config for staking-miner |
| generateConfig.image | object | `{"pullPolicy":"IfNotPresent","pullSecrets":[],"registry":"docker.io","repository":"paritytech/tools","tag":"latest"}` | Image configuration |
| generateConfig.image.pullPolicy | string | `"IfNotPresent"` | Specify a imagePullPolicy Defaults to 'Always' if image tag is 'latest', else set to 'IfNotPresent' ref: http://kubernetes.io/docs/user-guide/images/#pre-pulling-images |
| generateConfig.image.pullSecrets | list | `[]` | Optionally specify an array of imagePullSecrets. Secrets must be manually created in the namespace. ref: https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/ e.g: pullSecrets:   - myRegistryKeySecretName |
| generateConfig.image.registry | string | `"docker.io"` | init-container image registry |
| generateConfig.image.repository | string | `"paritytech/tools"` | init-container image repository |
| generateConfig.image.tag | string | `"latest"` | init-container image tag |
| generateConfig.resources | object | `{}` | init-container requests/limits |
| global | object | `{"imagePullSecrets":[],"imageRegistry":""}` | Global Docker image parameters |
| global.imagePullSecrets | list | `[]` | Docker registry secret names as an array |
| global.imageRegistry | string | `""` | Docker image registry |
| hostAliases | list | `[]` | staking-miner pods host aliases https://kubernetes.io/docs/concepts/services-networking/add-entries-to-pod-etc-hosts-with-host-aliases/ |
| image | object | `{"pullPolicy":"IfNotPresent","pullSecrets":[],"registry":"docker.io","repository":"paritytech/staking-miner","tag":"master"}` | Parity staking-miner image ref: https://hub.docker.com/r/paritytech/staking-miner/tags/ |
| image.pullPolicy | string | `"IfNotPresent"` | Specify a imagePullPolicy Defaults to 'Always' if image tag is 'latest', else set to 'IfNotPresent' ref: http://kubernetes.io/docs/user-guide/images/#pre-pulling-images |
| image.pullSecrets | list | `[]` | Optionally specify an array of imagePullSecrets. Secrets must be manually created in the namespace. ref: https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/ e.g: pullSecrets:   - myRegistryKeySecretName |
| image.registry | string | `"docker.io"` | staking-miner image registry |
| image.repository | string | `"paritytech/staking-miner"` | staking-miner image repository |
| image.tag | string | `"master"` | staking-miner image tag (immutable tags are recommended) |
| initContainers | object | `{}` | Add additional init containers to the staking-miner pod(s) ref: https://kubernetes.io/docs/concepts/workloads/pods/init-containers/ e.g: initContainers:  - name: your-image-name    image: your-image    imagePullPolicy: Always    command: ['sh', '-c', 'echo "hello world"'] |
| kubeVersion | string | `""` | Override Kubernetes version |
| lifecycleHooks | object | `{}` | lifecycleHooks for the staking-miner container(s) to automate configuration before or after startup |
| nameOverride | string | `""` | Provide a name in place of node for `app:` labels |
| namespaceOverride | string | `""` | Override namespace where the chart is deployed |
| nodeAffinityPreset | object | `{"key":"","type":"","values":[]}` | Node affinity preset ref: https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#node-affinity |
| nodeAffinityPreset.key | string | `""` | Node label key to match. Ignored if `affinity` is set |
| nodeAffinityPreset.type | string | `""` | Node affinity preset type. Ignored if `affinity` is set. Allowed values: `soft` or `hard` |
| nodeAffinityPreset.values | list | `[]` | Node label values to match. Ignored if `affinity` is set E.g. values:   - e2e-az1   - e2e-az2 |
| nodeSelector | object | `{}` | Node labels for staking-miner pods assignment ref: https://kubernetes.io/docs/user-guide/node-selection/ |
| pdb | object | `{"create":false,"maxUnavailable":"","minAvailable":1}` | Pod Disruption Budget configuration ref: https://kubernetes.io/docs/tasks/run-application/configure-pdb |
| pdb.create | bool | `false` | Enable/disable a Pod Disruption Budget creation |
| pdb.maxUnavailable | string | `""` | Maximum number/percentage of pods that may be made unavailable |
| pdb.minAvailable | int | `1` | Minimum number/percentage of pods that should remain scheduled |
| podAffinityPreset | string | `""` | Pod affinity preset. Ignored if `affinity` is set. Allowed values: `soft` or `hard` ref: https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#inter-pod-affinity-and-anti-affinity |
| podAnnotations | object | `{}` | Annotations for staking-miner pods ref: https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations/ |
| podAntiAffinityPreset | string | `"soft"` | Pod anti-affinity preset. Ignored if `affinity` is set. Allowed values: `soft` or `hard` ref: https://kubernetes.io/docs/concepts/schedulinfg-eviction/assign-pod-node/#inter-pod-afinity-and-anti-affinity |
| podLabels | object | `{}` |  |
| podManagementPolicy | string | `"OrderedReady"` | Statefulset Pod management policy, it needs to be Parallel to be able to complete the cluster join Ref: https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/#pod-management-policies |
| podSecurityContext | object | `{"enabled":true,"fsGroup":1001}` | Configure Pods Security Context ref: https://kubernetes.io/docs/tasks/configure-pod-container/security-context/#set-the-security-context-for-a-pod |
| podSecurityContext.enabled | bool | `true` | Enable staking-miner pods' Security Context |
| podSecurityContext.fsGroup | int | `1001` | Set staking-miner pods' Security Context fsGroup |
| priorityClassName | string | `""` | staking-miner pods' priorityClassName |
| rbac.create | bool | `false` | Specifies whether RBAC resources should be created |
| rbac.rules | list | `[]` | Custom RBAC rules to set e.g: rules:   - apiGroups:       - ""     resources:       - pods     verbs:       - get       - list |
| replicaCount | int | `1` | Number of staking-miner replicas to deploy |
| resources | object | `{"limits":{},"requests":{}}` | staking-miner resource requests and limits ref: http://kubernetes.io/docs/user-guide/compute-resources/ |
| resources.limits | object | `{}` | The resources limits for the staking-miner containers |
| resources.requests | object | `{}` | The requested resources for the staking-miner containers |
| schedulerName | string | `""` | Name of the k8s scheduler (other than default) for staking-miner pods ref: https://kubernetes.io/docs/tasks/administer-cluster/configure-multiple-schedulers/ |
| serviceAccount.annotations | object | `{}` | Additional Service Account annotations (evaluated as a template) |
| serviceAccount.automountServiceAccountToken | bool | `true` | Automount service account token for the server service account |
| serviceAccount.create | bool | `true` | Specifies whether a ServiceAccount should be created |
| serviceAccount.name | string | `""` | The name of the ServiceAccount to use. If not set and create is true, a name is generated using the common.names.fullname template |
| serviceMonitor.annotations | object | `{}` | Set the ServiceMonitor annotations |
| serviceMonitor.enabled | bool | `false` | Specifies whether a ServiceMonitor should be created |
| serviceMonitor.endpoint | object | `{"honorLabels":true,"interval":"1m","path":"/metrics","port":"prom","scheme":"http","scrapeTimeout":"30s"}` | Prometheus endpoints scrape configuration |
| serviceMonitor.endpoint.honorLabels | bool | `true` | Chooses the metric’s labels on collisions with target labels. |
| serviceMonitor.endpoint.interval | string | `"1m"` | Interval at which metrics should be scraped |
| serviceMonitor.endpoint.path | string | `"/metrics"` | HTTP path to scrape for metrics. |
| serviceMonitor.endpoint.port | string | `"prom"` | Name of the service port this endpoint refers to |
| serviceMonitor.endpoint.scheme | string | `"http"` | HTTP scheme to use for scraping. |
| serviceMonitor.endpoint.scrapeTimeout | string | `"30s"` | Timeout after which the scrape is ended |
| sidecars | object | `{}` | Add additional sidecar containers to the staking-miner pod(s) e.g: sidecars:   - name: your-image-name     image: your-image     imagePullPolicy: Always     ports:       - name: portname         containerPort: 1234 |
| stakingMiner | object | `{"config":"[{\"seed\":\"0x44\",\"uri\":\"ws://localhost:443\"}]","existingSecret":"","prometheus":{"enabled":false,"port":9999}}` | staking-miner Parameters |
| stakingMiner.config | string | `"[{\"seed\":\"0x44\",\"uri\":\"ws://localhost:443\"}]"` | A config for staking miner. Parameter is parsed as a JSON string containing a list of dicts. A number of dicts must match the number of replicas. Each dict may contain a 'seed' and 'uri' keys. Its values matches the SEED and URI environment variables as defined in staking-miner. |
| stakingMiner.existingSecret | string | `""` | A name of the existing secret with staking-miner's config. Must be a JSON encoded string that matches stakingMiner.config's format. See secrets.yaml |
| stakingMiner.prometheus | object | `{"enabled":false,"port":9999}` | Prometheus exporter configuration |
| stakingMiner.prometheus.enabled | bool | `false` | Enable exposing the Prometheus port |
| stakingMiner.prometheus.port | int | `9999` | Set the Prometheus port |
| terminationGracePeriodSeconds | string | `""` | Seconds a Pod needs to terminate gracefully ref: https://kubernetes.io/docs/concepts/workloads/pods/pod/#termination-of-pods |
| tolerations | list | `[]` | Tolerations for staking-miner pods assignment ref: https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/ |
| topologySpreadConstraints | object | `{}` | Topology Spread Constraints for pod assignment spread across your cluster among failure-domains. Evaluated as a template Ref: https://kubernetes.io/docs/concepts/workloads/pods/pod-topology-spread-constraints/#spread-constraints-for-pods |
| updateStrategy | object | `{"type":"RollingUpdate"}` | staking-miner statefulset strategy type ref: https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/#update-strategies |
| updateStrategy.type | string | `"RollingUpdate"` | StrategyType Can be set to RollingUpdate or OnDelete |
| waitRuntimeUpgrade | object | `{"enabled":false,"resources":{}}` | waitRuntimeUpgrade configuration |
| waitRuntimeUpgrade.enabled | bool | `false` | Wait until chain will have same spec version as staking miner |
| waitRuntimeUpgrade.resources | object | `{}` | Resources configuration for the wait container |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.11.0](https://github.com/norwoodj/helm-docs/releases/v1.11.0)
