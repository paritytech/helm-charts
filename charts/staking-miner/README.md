# Staking Miner Helm Chart

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
## Parameters

### Global parameters

| Name                      | Description                                     | Value |
| ------------------------- | ----------------------------------------------- | ----- |
| `global.imageRegistry`    | Global Docker image registry                    | `""`  |
| `global.imagePullSecrets` | Global Docker registry secret names as an array | `[]`  |


### Common parameters

| Name                     | Description                                                                             | Value           |
| ------------------------ | --------------------------------------------------------------------------------------- | --------------- |
| `kubeVersion`            | Override Kubernetes version                                                             | `""`            |
| `nameOverride`           | String to partially override common.names.name                                          | `""`            |
| `fullnameOverride`       | String to fully override common.names.fullname                                          | `""`            |
| `namespaceOverride`      | String to fully override common.names.namespace                                         | `""`            |
| `commonLabels`           | Labels to add to all deployed objects                                                   | `{}`            |
| `commonAnnotations`      | Annotations to add to all deployed objects                                              | `{}`            |
| `clusterDomain`          | Kubernetes cluster domain name                                                          | `cluster.local` |
| `extraDeploy`            | Array of extra objects to deploy with the release                                       | `[]`            |
| `diagnosticMode.enabled` | Enable diagnostic mode (all probes will be disabled and the command will be overridden) | `false`         |
| `diagnosticMode.command` | Command to override all containers in the deployment                                    | `["sleep"]`     |
| `diagnosticMode.args`    | Args to override all containers in the deployment                                       | `["infinity"]`  |


### staking-miner Parameters

| Name                                              | Description                                                                                                                                                                                                                                                                             | Value                                                                                                |
| ------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------- |
| `stakingMiner.config`                             | A config for staking miner. Parameter is parsed as a JSON string containing a list of dicts. A number of dicts must match the number of replicas. Each dict may contain a 'seed' and 'uri' keys. Its values matches the SEED and URI environment variables as defined in staking-miner. | `[{"seed":"0x44","uri":"ws://localhost:443"}]`                                                       |
| `stakingMiner.existingSecret`                     | A name of the existing secret with staking-miner's config. Must be a JSON encoded string that matches stakingMiner.config's format. See secrets.yaml                                                                                                                                    | `""`                                                                                                 |
| `stakingMiner.prometheus.enabled`                 | Enable exposing the prometheus port                                                                                                                                                                                                                                                     | `false`                                                                                              |
| `stakingMiner.prometheus.port`                    | Set the prometheus port                                                                                                                                                                                                                                                                 | `9999`                                                                                               |
| `generateConfig.image.registry`                   | init-container image registry                                                                                                                                                                                                                                                           | `docker.io`                                                                                          |
| `generateConfig.image.repository`                 | init-container image repository                                                                                                                                                                                                                                                         | `paritytech/tools`                                                                                   |
| `generateConfig.image.tag`                        | init-container image tag (immutable tags are recommended)                                                                                                                                                                                                                               | `latest`                                                                                             |
| `generateConfig.image.pullPolicy`                 | init-container image pull policy                                                                                                                                                                                                                                                        | `IfNotPresent`                                                                                       |
| `generateConfig.image.pullSecrets`                | init-container image pull secrets                                                                                                                                                                                                                                                       | `[]`                                                                                                 |
| `waitRuntimeUpgrade.enabled`                      | Wait until chain will have same spec version as staking miner                                                                                                                                                                                                                          | `false`                                                                                              |
| `waitRuntimeUpgrade.resources`                    | Resources configuration for the wait container                                                                                                                                                                                                                          | `{}`                                                                                              |
| `image.registry`                                  | staking-miner image registry                                                                                                                                                                                                                                                            | `docker.io`                                                                                          |
| `image.repository`                                | staking-miner image repository                                                                                                                                                                                                                                                          | `paritytech/staking-miner`                                                                           |
| `image.tag`                                       | staking-miner image tag (immutable tags are recommended)                                                                                                                                                                                                                                | `master`                                                                                             |
| `image.pullPolicy`                                | staking-miner image pull policy                                                                                                                                                                                                                                                         | `IfNotPresent`                                                                                       |
| `image.pullSecrets`                               | staking-miner image pull secrets                                                                                                                                                                                                                                                        | `[]`                                                                                                 |
| `replicaCount`                                    | Number of staking-miner replicas to deploy                                                                                                                                                                                                                                              | `1`                                                                                                  |
| `customLivenessProbe`                             | Custom livenessProbe that overrides the default one                                                                                                                                                                                                                                     | `{}`                                                                                                 |
| `customReadinessProbe`                            | Custom readinessProbe that overrides the default one                                                                                                                                                                                                                                    | `{}`                                                                                                 |
| `customStartupProbe`                              | Custom startupProbe that overrides the default one                                                                                                                                                                                                                                      | `{}`                                                                                                 |
| `resources.limits`                                | The resources limits for the staking-miner containers                                                                                                                                                                                                                                   | `{}`                                                                                                 |
| `resources.requests`                              | The requested resources for the staking-miner containers                                                                                                                                                                                                                                | `{}`                                                                                                 |
| `podSecurityContext.enabled`                      | Enabled staking-miner pods' Security Context                                                                                                                                                                                                                                            | `true`                                                                                               |
| `podSecurityContext.fsGroup`                      | Set staking-miner pod's Security Context fsGroup                                                                                                                                                                                                                                        | `1001`                                                                                               |
| `containerSecurityContext.enabled`                | Enabled staking-miner containers' Security Context                                                                                                                                                                                                                                      | `true`                                                                                               |
| `containerSecurityContext.runAsUser`              | Set staking-miner containers' Security Context runAsUser                                                                                                                                                                                                                                | `1001`                                                                                               |
| `containerSecurityContext.runAsNonRoot`           | Set staking-miner containers' Security Context runAsNonRoot                                                                                                                                                                                                                             | `true`                                                                                               |
| `containerSecurityContext.readOnlyRootFilesystem` | Set staking-miner containers' Security Context runAsNonRoot                                                                                                                                                                                                                             | `false`                                                                                              |
| `command`                                         | Override default container command (useful when using custom images)                                                                                                                                                                                                                    | `["/bin/sh"]`                                                                                        |
| `args`                                            | Override default container args (useful when using custom images)                                                                                                                                                                                                                       | `["-c","staking-miner monitor --seed-or-path /config/seed --uri $(cat /config/uri) seq-phragmen\n"]` |
| `hostAliases`                                     | staking-miner pods host aliases                                                                                                                                                                                                                                                         | `[]`                                                                                                 |
| `podLabels`                                       | Extra labels for staking-miner pods                                                                                                                                                                                                                                                     | `{}`                                                                                                 |
| `podAnnotations`                                  | Annotations for staking-miner pods                                                                                                                                                                                                                                                      | `{}`                                                                                                 |
| `podAffinityPreset`                               | Pod affinity preset. Ignored if `affinity` is set. Allowed values: `soft` or `hard`                                                                                                                                                                                                     | `""`                                                                                                 |
| `podAntiAffinityPreset`                           | Pod anti-affinity preset. Ignored if `affinity` is set. Allowed values: `soft` or `hard`                                                                                                                                                                                                | `soft`                                                                                               |
| `pdb.create`                                      | Enable/disable a Pod Disruption Budget creation                                                                                                                                                                                                                                         | `false`                                                                                              |
| `pdb.minAvailable`                                | Minimum number/percentage of pods that should remain scheduled                                                                                                                                                                                                                          | `1`                                                                                                  |
| `pdb.maxUnavailable`                              | Maximum number/percentage of pods that may be made unavailable                                                                                                                                                                                                                          | `""`                                                                                                 |
| `nodeAffinityPreset.type`                         | Node affinity preset type. Ignored if `affinity` is set. Allowed values: `soft` or `hard`                                                                                                                                                                                               | `""`                                                                                                 |
| `nodeAffinityPreset.key`                          | Node label key to match. Ignored if `affinity` is set                                                                                                                                                                                                                                   | `""`                                                                                                 |
| `nodeAffinityPreset.values`                       | Node label values to match. Ignored if `affinity` is set                                                                                                                                                                                                                                | `[]`                                                                                                 |
| `affinity`                                        | Affinity for staking-miner pods assignment                                                                                                                                                                                                                                              | `{}`                                                                                                 |
| `nodeSelector`                                    | Node labels for staking-miner pods assignment                                                                                                                                                                                                                                           | `{}`                                                                                                 |
| `tolerations`                                     | Tolerations for staking-miner pods assignment                                                                                                                                                                                                                                           | `[]`                                                                                                 |
| `updateStrategy.type`                             | staking-miner statefulset strategy type                                                                                                                                                                                                                                                 | `RollingUpdate`                                                                                      |
| `podManagementPolicy`                             | Statefulset Pod management policy, it needs to be Parallel to be able to complete the cluster join                                                                                                                                                                                      | `OrderedReady`                                                                                       |
| `priorityClassName`                               | staking-miner pods' priorityClassName                                                                                                                                                                                                                                                   | `""`                                                                                                 |
| `topologySpreadConstraints`                       | Topology Spread Constraints for pod assignment spread across your cluster among failure-domains. Evaluated as a template                                                                                                                                                                | `{}`                                                                                                 |
| `schedulerName`                                   | Name of the k8s scheduler (other than default) for staking-miner pods                                                                                                                                                                                                                   | `""`                                                                                                 |
| `terminationGracePeriodSeconds`                   | Seconds Redmine pod needs to terminate gracefully                                                                                                                                                                                                                                       | `""`                                                                                                 |
| `lifecycleHooks`                                  | for the staking-miner container(s) to automate configuration before or after startup                                                                                                                                                                                                    | `{}`                                                                                                 |
| `extraEnvVars`                                    | Array with extra environment variables to add to staking-miner nodes                                                                                                                                                                                                                    | `[]`                                                                                                 |
| `extraEnvVarsCM`                                  | Name of existing ConfigMap containing extra env vars for staking-miner nodes                                                                                                                                                                                                            | `""`                                                                                                 |
| `extraEnvVarsSecret`                              | Name of existing Secret containing extra env vars for staking-miner nodes                                                                                                                                                                                                               | `""`                                                                                                 |
| `extraVolumes`                                    | Optionally specify extra list of additional volumes for the staking-miner pod(s)                                                                                                                                                                                                        | `[]`                                                                                                 |
| `extraVolumeMounts`                               | Optionally specify extra list of additional volumeMounts for the staking-miner container(s)                                                                                                                                                                                             | `[]`                                                                                                 |
| `sidecars`                                        | Add additional sidecar containers to the staking-miner pod(s)                                                                                                                                                                                                                           | `{}`                                                                                                 |
| `initContainers`                                  | Add additional init containers to the staking-miner pod(s)                                                                                                                                                                                                                              | `{}`                                                                                                 |


### Other Parameters

| Name                                          | Description                                                      | Value      |
| --------------------------------------------- | ---------------------------------------------------------------- | ---------- |
| `rbac.create`                                 | Specifies whether RBAC resources should be created               | `false`    |
| `rbac.rules`                                  | Custom RBAC rules to set                                         | `[]`       |
| `serviceAccount.create`                       | Specifies whether a ServiceAccount should be created             | `true`     |
| `serviceAccount.name`                         | The name of the ServiceAccount to use.                           | `""`       |
| `serviceAccount.annotations`                  | Additional Service Account annotations (evaluated as a template) | `{}`       |
| `serviceAccount.automountServiceAccountToken` | Automount service account token for the server service account   | `true`     |
| `serviceMonitor.enabled`                      | Specifies whether a ServiceMonitor should be created             | `false`    |
| `serviceMonitor.annotations`                  | Set the ServiceMonitor annotations                               | `{}`       |
| `serviceMonitor.endpoint.path`                | HTTP path to scrape for metrics.                                 | `/metrics` |
| `serviceMonitor.endpoint.port`                | Name of the service port this endpoint refers to                 | `prom`     |
| `serviceMonitor.endpoint.interval`            | Interval at which metrics should be scraped                      | `1m`       |
| `serviceMonitor.endpoint.scheme`              | HTTP scheme to use for scraping.                                 | `http`     |
| `serviceMonitor.endpoint.scrapeTimeout`       | Timeout after which the scrape is ended                          | `30s`      |
| `serviceMonitor.endpoint.honorLabels`         | Chooses the metric’s labels on collisions with target labels.    | `true`     |


