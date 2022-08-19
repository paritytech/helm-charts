# Polkadot Runtime Exporter Helm Chart

## TL;DR

```console
$ helm repo add bitnami https://charts.bitnami.com/bitnami
$ helm repo add parity https://paritytech.github.io/helm-charts/
$ helm dependency build
$ helm install runtime-exporter parity/runtime-exporter
```

## Introduction

A Helm chart for the [polkadot-runtime-exporter](https://github.com/paritytech/polkadot-runtime-prom-exporter)

## Prerequisites

- Kubernetes 1.19+
- Helm 3.2.0+

## Installing the Chart

To install the chart with the release name `runtime-exporter`:

```console
helm install runtime-exporter parity/runtime-exporter
```

The command deploys runtime-exporter on the Kubernetes cluster in the default configuration. The [Parameters](#parameters) section lists the parameters that can be configured during installation.

> **Tip**: List all releases using `helm list`

## Uninstalling the Chart

To uninstall/delete the `runtime-exporter` deployment:

```console
helm delete runtime-exporter
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

> **NOTE**: The Helm chart uses [readme-generator](https://github.com/bitnami-labs/readme-generator-for-helm) to generate [Parameters](#parameters) section. Make sure to update the parameters with that tool instead of manually editing it.

## Parameters

### Global parameters

| Name | Description | Value |
| ---- | ----------- | ----- |


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


### runtime-exporter Parameters

| Name                                              | Description                                                                                                              | Value                                       |
| ------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------- |
| `runtimeExporter.config`                          | The content of the config.json file for runtime exporter.                                                                | `{
  "rpcs": ["wss://rpc.polkadot.io"]
}
`  |
| `runtimeExporter.prometheus.enabled`              | Enable exposing the prometheus port                                                                                      | `true`                                      |
| `runtimeExporter.prometheus.port`                 | Set the prometheus port                                                                                                  | `8000`                                      |
| `runtimeExporter.prometheus.port`                 | Set the prometheus port                                                                                                  | `8000`                                      |
| `runtimeExporter.tsdbConnectionUrl`               | Connection URL of the TSDB database                                                                                      | `""`                                        |
| `image.registry`                                  | runtime-exporter image registry                                                                                          | `docker.io`                                 |
| `image.repository`                                | runtime-exporter image repository                                                                                        | `paritytech/polkadot-runtime-prom-exporter` |
| `image.tag`                                       | runtime-exporter image tag (immutable tags are recommended)                                                              | `latest`                                    |
| `image.pullPolicy`                                | runtime-exporter image pull policy                                                                                       | `IfNotPresent`                              |
| `image.pullSecrets`                               | runtime-exporter image pull secrets                                                                                      | `[]`                                        |
| `replicaCount`                                    | Number of runtime-exporter replicas to deploy                                                                            | `1`                                         |
| `customLivenessProbe`                             | Custom livenessProbe that overrides the default one                                                                      | `{}`                                        |
| `customReadinessProbe`                            | Custom readinessProbe that overrides the default one                                                                     | `{}`                                        |
| `customStartupProbe`                              | Custom startupProbe that overrides the default one                                                                       | `{}`                                        |
| `resources.limits`                                | The resources limits for the runtime-exporter containers                                                                 | `{}`                                        |
| `resources.requests`                              | The requested resources for the runtime-exporter containers                                                              | `{}`                                        |
| `podSecurityContext.enabled`                      | Enabled runtime-exporter pods' Security Context                                                                          | `true`                                      |
| `podSecurityContext.fsGroup`                      | Set runtime-exporter pod's Security Context fsGroup                                                                      | `1001`                                      |
| `containerSecurityContext.enabled`                | Enabled runtime-exporter containers' Security Context                                                                    | `true`                                      |
| `containerSecurityContext.runAsUser`              | Set runtime-exporter containers' Security Context runAsUser                                                              | `1001`                                      |
| `containerSecurityContext.runAsNonRoot`           | Set runtime-exporter containers' Security Context runAsNonRoot                                                           | `true`                                      |
| `containerSecurityContext.readOnlyRootFilesystem` | Set runtime-exporter containers' Security Context runAsNonRoot                                                           | `false`                                     |
| `hostAliases`                                     | runtime-exporter pods host aliases                                                                                       | `[]`                                        |
| `podLabels`                                       | Extra labels for runtime-exporter pods                                                                                   | `{}`                                        |
| `podAnnotations`                                  | Annotations for runtime-exporter pods                                                                                    | `{}`                                        |
| `podAffinityPreset`                               | Pod affinity preset. Ignored if `affinity` is set. Allowed values: `soft` or `hard`                                      | `""`                                        |
| `podAntiAffinityPreset`                           | Pod anti-affinity preset. Ignored if `affinity` is set. Allowed values: `soft` or `hard`                                 | `soft`                                      |
| `pdb.create`                                      | Enable/disable a Pod Disruption Budget creation                                                                          | `false`                                     |
| `pdb.minAvailable`                                | Minimum number/percentage of pods that should remain scheduled                                                           | `1`                                         |
| `pdb.maxUnavailable`                              | Maximum number/percentage of pods that may be made unavailable                                                           | `""`                                        |
| `nodeAffinityPreset.type`                         | Node affinity preset type. Ignored if `affinity` is set. Allowed values: `soft` or `hard`                                | `""`                                        |
| `nodeAffinityPreset.key`                          | Node label key to match. Ignored if `affinity` is set                                                                    | `""`                                        |
| `nodeAffinityPreset.values`                       | Node label values to match. Ignored if `affinity` is set                                                                 | `[]`                                        |
| `affinity`                                        | Affinity for runtime-exporter pods assignment                                                                            | `{}`                                        |
| `nodeSelector`                                    | Node labels for runtime-exporter pods assignment                                                                         | `{}`                                        |
| `tolerations`                                     | Tolerations for runtime-exporter pods assignment                                                                         | `[]`                                        |
| `updateStrategy.type`                             | runtime-exporter statefulset strategy type                                                                               | `RollingUpdate`                             |
| `podManagementPolicy`                             | Statefulset Pod management policy, it needs to be Parallel to be able to complete the cluster join                       | `OrderedReady`                              |
| `priorityClassName`                               | runtime-exporter pods' priorityClassName                                                                                 | `""`                                        |
| `topologySpreadConstraints`                       | Topology Spread Constraints for pod assignment spread across your cluster among failure-domains. Evaluated as a template | `{}`                                        |
| `schedulerName`                                   | Name of the k8s scheduler (other than default) for runtime-exporter pods                                                 | `""`                                        |
| `terminationGracePeriodSeconds`                   | Seconds Redmine pod needs to terminate gracefully                                                                        | `""`                                        |
| `lifecycleHooks`                                  | for the runtime-exporter container(s) to automate configuration before or after startup                                  | `{}`                                        |
| `sidecars`                                        | Add additional sidecar containers to the runtime-exporter pod(s)                                                         | `{}`                                        |
| `initContainers`                                  | Add additional init containers to the runtime-exporter pod(s)                                                            | `{}`                                        |


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
| `serviceMonitor.endpoint.interval`            | Interval at which metrics should be scraped                      | `6s`       |
| `serviceMonitor.endpoint.scheme`              | HTTP scheme to use for scraping.                                 | `http`     |
| `serviceMonitor.endpoint.scrapeTimeout`       | Timeout after which the scrape is ended                          | `30s`      |
| `serviceMonitor.endpoint.honorLabels`         | Chooses the metric’s labels on collisions with target labels.    | `true`     |


  "rpcs": ["wss://rpc.polkadot.io"]
}
`  |
| `runtimeExporter.prometheus.enabled`              | Enable exposing the prometheus port                                                                                      | `true`                                      |
| `runtimeExporter.prometheus.port`                 | Set the prometheus port                                                                                                  | `8000`                                      |
| `image.registry`                                  | runtime-exporter image registry                                                                                          | `docker.io`                                 |
| `image.repository`                                | runtime-exporter image repository                                                                                        | `paritytech/polkadot-runtime-prom-exporter` |
| `image.tag`                                       | runtime-exporter image tag (immutable tags are recommended)                                                              | `latest`                                    |
| `image.pullPolicy`                                | runtime-exporter image pull policy                                                                                       | `IfNotPresent`                              |
| `image.pullSecrets`                               | runtime-exporter image pull secrets                                                                                      | `[]`                                        |
| `replicaCount`                                    | Number of runtime-exporter replicas to deploy                                                                            | `1`                                         |
| `customLivenessProbe`                             | Custom livenessProbe that overrides the default one                                                                      | `{}`                                        |
| `customReadinessProbe`                            | Custom readinessProbe that overrides the default one                                                                     | `{}`                                        |
| `customStartupProbe`                              | Custom startupProbe that overrides the default one                                                                       | `{}`                                        |
| `resources.limits`                                | The resources limits for the runtime-exporter containers                                                                 | `{}`                                        |
| `resources.requests`                              | The requested resources for the runtime-exporter containers                                                              | `{}`                                        |
| `podSecurityContext.enabled`                      | Enabled runtime-exporter pods' Security Context                                                                          | `true`                                      |
| `podSecurityContext.fsGroup`                      | Set runtime-exporter pod's Security Context fsGroup                                                                      | `1001`                                      |
| `containerSecurityContext.enabled`                | Enabled runtime-exporter containers' Security Context                                                                    | `true`                                      |
| `containerSecurityContext.runAsUser`              | Set runtime-exporter containers' Security Context runAsUser                                                              | `1001`                                      |
| `containerSecurityContext.runAsNonRoot`           | Set runtime-exporter containers' Security Context runAsNonRoot                                                           | `true`                                      |
| `containerSecurityContext.readOnlyRootFilesystem` | Set runtime-exporter containers' Security Context runAsNonRoot                                                           | `false`                                     |
| `hostAliases`                                     | runtime-exporter pods host aliases                                                                                       | `[]`                                        |
| `podLabels`                                       | Extra labels for runtime-exporter pods                                                                                   | `{}`                                        |
| `podAnnotations`                                  | Annotations for runtime-exporter pods                                                                                    | `{}`                                        |
| `podAffinityPreset`                               | Pod affinity preset. Ignored if `affinity` is set. Allowed values: `soft` or `hard`                                      | `""`                                        |
| `podAntiAffinityPreset`                           | Pod anti-affinity preset. Ignored if `affinity` is set. Allowed values: `soft` or `hard`                                 | `soft`                                      |
| `pdb.create`                                      | Enable/disable a Pod Disruption Budget creation                                                                          | `false`                                     |
| `pdb.minAvailable`                                | Minimum number/percentage of pods that should remain scheduled                                                           | `1`                                         |
| `pdb.maxUnavailable`                              | Maximum number/percentage of pods that may be made unavailable                                                           | `""`                                        |
| `nodeAffinityPreset.type`                         | Node affinity preset type. Ignored if `affinity` is set. Allowed values: `soft` or `hard`                                | `""`                                        |
| `nodeAffinityPreset.key`                          | Node label key to match. Ignored if `affinity` is set                                                                    | `""`                                        |
| `nodeAffinityPreset.values`                       | Node label values to match. Ignored if `affinity` is set                                                                 | `[]`                                        |
| `affinity`                                        | Affinity for runtime-exporter pods assignment                                                                            | `{}`                                        |
| `nodeSelector`                                    | Node labels for runtime-exporter pods assignment                                                                         | `{}`                                        |
| `tolerations`                                     | Tolerations for runtime-exporter pods assignment                                                                         | `[]`                                        |
| `updateStrategy.type`                             | runtime-exporter statefulset strategy type                                                                               | `RollingUpdate`                             |
| `podManagementPolicy`                             | Statefulset Pod management policy, it needs to be Parallel to be able to complete the cluster join                       | `OrderedReady`                              |
| `priorityClassName`                               | runtime-exporter pods' priorityClassName                                                                                 | `""`                                        |
| `topologySpreadConstraints`                       | Topology Spread Constraints for pod assignment spread across your cluster among failure-domains. Evaluated as a template | `{}`                                        |
| `schedulerName`                                   | Name of the k8s scheduler (other than default) for runtime-exporter pods                                                 | `""`                                        |
| `terminationGracePeriodSeconds`                   | Seconds Redmine pod needs to terminate gracefully                                                                        | `""`                                        |
| `lifecycleHooks`                                  | for the runtime-exporter container(s) to automate configuration before or after startup                                  | `{}`                                        |
| `sidecars`                                        | Add additional sidecar containers to the runtime-exporter pod(s)                                                         | `{}`                                        |
| `initContainers`                                  | Add additional init containers to the runtime-exporter pod(s)                                                            | `{}`                                        |


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
| `serviceMonitor.endpoint.interval`            | Interval at which metrics should be scraped                      | `6s`       |
| `serviceMonitor.endpoint.scheme`              | HTTP scheme to use for scraping.                                 | `http`     |
| `serviceMonitor.endpoint.scrapeTimeout`       | Timeout after which the scrape is ended                          | `30s`      |
| `serviceMonitor.endpoint.honorLabels`         | Chooses the metric’s labels on collisions with target labels.    | `true`     |


  "rpcs": [
    "wss://rpc.polkadot.io",
    "wss://kusama-rpc.polkadot.io"
  ]
}
` |
| `runtimeExporter.prometheus.enabled`              | Enable exposing the prometheus port                                                                                      | `true`                                                                                 |
| `runtimeExporter.prometheus.port`                 | Set the prometheus port                                                                                                  | `8000`                                                                                 |
| `image.registry`                                  | runtime-exporter image registry                                                                                          | `docker.io`                                                                            |
| `image.repository`                                | runtime-exporter image repository                                                                                        | `paritytech/polkadot-runtime-prom-exporter`                                            |
| `image.tag`                                       | runtime-exporter image tag (immutable tags are recommended)                                                              | `latest`                                                                               |
| `image.pullPolicy`                                | runtime-exporter image pull policy                                                                                       | `IfNotPresent`                                                                         |
| `image.pullSecrets`                               | runtime-exporter image pull secrets                                                                                      | `[]`                                                                                   |
| `replicaCount`                                    | Number of runtime-exporter replicas to deploy                                                                            | `1`                                                                                    |
| `customLivenessProbe`                             | Custom livenessProbe that overrides the default one                                                                      | `{}`                                                                                   |
| `customReadinessProbe`                            | Custom readinessProbe that overrides the default one                                                                     | `{}`                                                                                   |
| `customStartupProbe`                              | Custom startupProbe that overrides the default one                                                                       | `{}`                                                                                   |
| `resources.limits`                                | The resources limits for the runtime-exporter containers                                                                 | `{}`                                                                                   |
| `resources.requests`                              | The requested resources for the runtime-exporter containers                                                              | `{}`                                                                                   |
| `podSecurityContext.enabled`                      | Enabled runtime-exporter pods' Security Context                                                                          | `true`                                                                                 |
| `podSecurityContext.fsGroup`                      | Set runtime-exporter pod's Security Context fsGroup                                                                      | `1001`                                                                                 |
| `containerSecurityContext.enabled`                | Enabled runtime-exporter containers' Security Context                                                                    | `true`                                                                                 |
| `containerSecurityContext.runAsUser`              | Set runtime-exporter containers' Security Context runAsUser                                                              | `1001`                                                                                 |
| `containerSecurityContext.runAsNonRoot`           | Set runtime-exporter containers' Security Context runAsNonRoot                                                           | `true`                                                                                 |
| `containerSecurityContext.readOnlyRootFilesystem` | Set runtime-exporter containers' Security Context runAsNonRoot                                                           | `false`                                                                                |
| `hostAliases`                                     | runtime-exporter pods host aliases                                                                                       | `[]`                                                                                   |
| `podLabels`                                       | Extra labels for runtime-exporter pods                                                                                   | `{}`                                                                                   |
| `podAnnotations`                                  | Annotations for runtime-exporter pods                                                                                    | `{}`                                                                                   |
| `podAffinityPreset`                               | Pod affinity preset. Ignored if `affinity` is set. Allowed values: `soft` or `hard`                                      | `""`                                                                                   |
| `podAntiAffinityPreset`                           | Pod anti-affinity preset. Ignored if `affinity` is set. Allowed values: `soft` or `hard`                                 | `soft`                                                                                 |
| `pdb.create`                                      | Enable/disable a Pod Disruption Budget creation                                                                          | `false`                                                                                |
| `pdb.minAvailable`                                | Minimum number/percentage of pods that should remain scheduled                                                           | `1`                                                                                    |
| `pdb.maxUnavailable`                              | Maximum number/percentage of pods that may be made unavailable                                                           | `""`                                                                                   |
| `nodeAffinityPreset.type`                         | Node affinity preset type. Ignored if `affinity` is set. Allowed values: `soft` or `hard`                                | `""`                                                                                   |
| `nodeAffinityPreset.key`                          | Node label key to match. Ignored if `affinity` is set                                                                    | `""`                                                                                   |
| `nodeAffinityPreset.values`                       | Node label values to match. Ignored if `affinity` is set                                                                 | `[]`                                                                                   |
| `affinity`                                        | Affinity for runtime-exporter pods assignment                                                                            | `{}`                                                                                   |
| `nodeSelector`                                    | Node labels for runtime-exporter pods assignment                                                                         | `{}`                                                                                   |
| `tolerations`                                     | Tolerations for runtime-exporter pods assignment                                                                         | `[]`                                                                                   |
| `updateStrategy.type`                             | runtime-exporter statefulset strategy type                                                                               | `RollingUpdate`                                                                        |
| `podManagementPolicy`                             | Statefulset Pod management policy, it needs to be Parallel to be able to complete the cluster join                       | `OrderedReady`                                                                         |
| `priorityClassName`                               | runtime-exporter pods' priorityClassName                                                                                 | `""`                                                                                   |
| `topologySpreadConstraints`                       | Topology Spread Constraints for pod assignment spread across your cluster among failure-domains. Evaluated as a template | `{}`                                                                                   |
| `schedulerName`                                   | Name of the k8s scheduler (other than default) for runtime-exporter pods                                                 | `""`                                                                                   |
| `terminationGracePeriodSeconds`                   | Seconds Redmine pod needs to terminate gracefully                                                                        | `""`                                                                                   |
| `lifecycleHooks`                                  | for the runtime-exporter container(s) to automate configuration before or after startup                                  | `{}`                                                                                   |
| `sidecars`                                        | Add additional sidecar containers to the runtime-exporter pod(s)                                                         | `{}`                                                                                   |
| `initContainers`                                  | Add additional init containers to the runtime-exporter pod(s)                                                            | `{}`                                                                                   |


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
| `serviceMonitor.endpoint.interval`            | Interval at which metrics should be scraped                      | `6s`       |
| `serviceMonitor.endpoint.scheme`              | HTTP scheme to use for scraping.                                 | `http`     |
| `serviceMonitor.endpoint.scrapeTimeout`       | Timeout after which the scrape is ended                          | `30s`      |
| `serviceMonitor.endpoint.honorLabels`         | Chooses the metric’s labels on collisions with target labels.    | `true`     |


  "rpcs": [
    "wss://rpc.polkadot.io",
    "wss://kusama-rpc.polkadot.io"
  ]
}
` |
| `runtimeExporter.prometheus.enabled`              | Enable exposing the prometheus port                                                                                      | `true`                                                                                 |
| `runtimeExporter.prometheus.port`                 | Set the prometheus port                                                                                                  | `8000`                                                                                 |
| `image.registry`                                  | runtime-exporter image registry                                                                                          | `docker.io`                                                                            |
| `image.repository`                                | runtime-exporter image repository                                                                                        | `paritytech/polkadot-runtime-prom-exporter`                                            |
| `image.tag`                                       | runtime-exporter image tag (immutable tags are recommended)                                                              | `latest`                                                                               |
| `image.pullPolicy`                                | runtime-exporter image pull policy                                                                                       | `IfNotPresent`                                                                         |
| `image.pullSecrets`                               | runtime-exporter image pull secrets                                                                                      | `[]`                                                                                   |
| `replicaCount`                                    | Number of runtime-exporter replicas to deploy                                                                            | `1`                                                                                    |
| `customLivenessProbe`                             | Custom livenessProbe that overrides the default one                                                                      | `{}`                                                                                   |
| `customReadinessProbe`                            | Custom readinessProbe that overrides the default one                                                                     | `{}`                                                                                   |
| `customStartupProbe`                              | Custom startupProbe that overrides the default one                                                                       | `{}`                                                                                   |
| `resources.limits`                                | The resources limits for the runtime-exporter containers                                                                 | `{}`                                                                                   |
| `resources.requests`                              | The requested resources for the runtime-exporter containers                                                              | `{}`                                                                                   |
| `podSecurityContext.enabled`                      | Enabled runtime-exporter pods' Security Context                                                                          | `true`                                                                                 |
| `podSecurityContext.fsGroup`                      | Set runtime-exporter pod's Security Context fsGroup                                                                      | `1001`                                                                                 |
| `containerSecurityContext.enabled`                | Enabled runtime-exporter containers' Security Context                                                                    | `true`                                                                                 |
| `containerSecurityContext.runAsUser`              | Set runtime-exporter containers' Security Context runAsUser                                                              | `1001`                                                                                 |
| `containerSecurityContext.runAsNonRoot`           | Set runtime-exporter containers' Security Context runAsNonRoot                                                           | `true`                                                                                 |
| `containerSecurityContext.readOnlyRootFilesystem` | Set runtime-exporter containers' Security Context runAsNonRoot                                                           | `false`                                                                                |
| `hostAliases`                                     | runtime-exporter pods host aliases                                                                                       | `[]`                                                                                   |
| `podLabels`                                       | Extra labels for runtime-exporter pods                                                                                   | `{}`                                                                                   |
| `podAnnotations`                                  | Annotations for runtime-exporter pods                                                                                    | `{}`                                                                                   |
| `podAffinityPreset`                               | Pod affinity preset. Ignored if `affinity` is set. Allowed values: `soft` or `hard`                                      | `""`                                                                                   |
| `podAntiAffinityPreset`                           | Pod anti-affinity preset. Ignored if `affinity` is set. Allowed values: `soft` or `hard`                                 | `soft`                                                                                 |
| `pdb.create`                                      | Enable/disable a Pod Disruption Budget creation                                                                          | `false`                                                                                |
| `pdb.minAvailable`                                | Minimum number/percentage of pods that should remain scheduled                                                           | `1`                                                                                    |
| `pdb.maxUnavailable`                              | Maximum number/percentage of pods that may be made unavailable                                                           | `""`                                                                                   |
| `nodeAffinityPreset.type`                         | Node affinity preset type. Ignored if `affinity` is set. Allowed values: `soft` or `hard`                                | `""`                                                                                   |
| `nodeAffinityPreset.key`                          | Node label key to match. Ignored if `affinity` is set                                                                    | `""`                                                                                   |
| `nodeAffinityPreset.values`                       | Node label values to match. Ignored if `affinity` is set                                                                 | `[]`                                                                                   |
| `affinity`                                        | Affinity for runtime-exporter pods assignment                                                                            | `{}`                                                                                   |
| `nodeSelector`                                    | Node labels for runtime-exporter pods assignment                                                                         | `{}`                                                                                   |
| `tolerations`                                     | Tolerations for runtime-exporter pods assignment                                                                         | `[]`                                                                                   |
| `updateStrategy.type`                             | runtime-exporter statefulset strategy type                                                                               | `RollingUpdate`                                                                        |
| `podManagementPolicy`                             | Statefulset Pod management policy, it needs to be Parallel to be able to complete the cluster join                       | `OrderedReady`                                                                         |
| `priorityClassName`                               | runtime-exporter pods' priorityClassName                                                                                 | `""`                                                                                   |
| `topologySpreadConstraints`                       | Topology Spread Constraints for pod assignment spread across your cluster among failure-domains. Evaluated as a template | `{}`                                                                                   |
| `schedulerName`                                   | Name of the k8s scheduler (other than default) for runtime-exporter pods                                                 | `""`                                                                                   |
| `terminationGracePeriodSeconds`                   | Seconds Redmine pod needs to terminate gracefully                                                                        | `""`                                                                                   |
| `lifecycleHooks`                                  | for the runtime-exporter container(s) to automate configuration before or after startup                                  | `{}`                                                                                   |
| `sidecars`                                        | Add additional sidecar containers to the runtime-exporter pod(s)                                                         | `{}`                                                                                   |
| `initContainers`                                  | Add additional init containers to the runtime-exporter pod(s)                                                            | `{}`                                                                                   |


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
| `serviceMonitor.endpoint.interval`            | Interval at which metrics should be scraped                      | `6s`       |
| `serviceMonitor.endpoint.scheme`              | HTTP scheme to use for scraping.                                 | `http`     |
| `serviceMonitor.endpoint.scrapeTimeout`       | Timeout after which the scrape is ended                          | `30s`      |
| `serviceMonitor.endpoint.honorLabels`         | Chooses the metric’s labels on collisions with target labels.    | `true`     |


  "rpcs": [
    "wss://rpc.polkadot.io",
    "wss://kusama-rpc.polkadot.io"
  ]
}
` |
| `runtimeExporter.prometheus.enabled`              | Enable exposing the prometheus port                                                                                      | `true`                                                                                 |
| `runtimeExporter.prometheus.port`                 | Set the prometheus port                                                                                                  | `8000`                                                                                 |
| `image.registry`                                  | runtime-exporter image registry                                                                                          | `docker.io`                                                                            |
| `image.repository`                                | runtime-exporter image repository                                                                                        | `paritytech/polkadot-runtime-prom-exporter`                                            |
| `image.tag`                                       | runtime-exporter image tag (immutable tags are recommended)                                                              | `latest`                                                                               |
| `image.pullPolicy`                                | runtime-exporter image pull policy                                                                                       | `IfNotPresent`                                                                         |
| `image.pullSecrets`                               | runtime-exporter image pull secrets                                                                                      | `[]`                                                                                   |
| `replicaCount`                                    | Number of runtime-exporter replicas to deploy                                                                            | `1`                                                                                    |
| `customLivenessProbe`                             | Custom livenessProbe that overrides the default one                                                                      | `{}`                                                                                   |
| `customReadinessProbe`                            | Custom readinessProbe that overrides the default one                                                                     | `{}`                                                                                   |
| `customStartupProbe`                              | Custom startupProbe that overrides the default one                                                                       | `{}`                                                                                   |
| `resources.limits`                                | The resources limits for the runtime-exporter containers                                                                 | `{}`                                                                                   |
| `resources.requests`                              | The requested resources for the runtime-exporter containers                                                              | `{}`                                                                                   |
| `podSecurityContext.enabled`                      | Enabled runtime-exporter pods' Security Context                                                                          | `true`                                                                                 |
| `podSecurityContext.fsGroup`                      | Set runtime-exporter pod's Security Context fsGroup                                                                      | `1001`                                                                                 |
| `containerSecurityContext.enabled`                | Enabled runtime-exporter containers' Security Context                                                                    | `true`                                                                                 |
| `containerSecurityContext.runAsUser`              | Set runtime-exporter containers' Security Context runAsUser                                                              | `1001`                                                                                 |
| `containerSecurityContext.runAsNonRoot`           | Set runtime-exporter containers' Security Context runAsNonRoot                                                           | `true`                                                                                 |
| `containerSecurityContext.readOnlyRootFilesystem` | Set runtime-exporter containers' Security Context runAsNonRoot                                                           | `false`                                                                                |
| `hostAliases`                                     | runtime-exporter pods host aliases                                                                                       | `[]`                                                                                   |
| `podLabels`                                       | Extra labels for runtime-exporter pods                                                                                   | `{}`                                                                                   |
| `podAnnotations`                                  | Annotations for runtime-exporter pods                                                                                    | `{}`                                                                                   |
| `podAffinityPreset`                               | Pod affinity preset. Ignored if `affinity` is set. Allowed values: `soft` or `hard`                                      | `""`                                                                                   |
| `podAntiAffinityPreset`                           | Pod anti-affinity preset. Ignored if `affinity` is set. Allowed values: `soft` or `hard`                                 | `soft`                                                                                 |
| `pdb.create`                                      | Enable/disable a Pod Disruption Budget creation                                                                          | `false`                                                                                |
| `pdb.minAvailable`                                | Minimum number/percentage of pods that should remain scheduled                                                           | `1`                                                                                    |
| `pdb.maxUnavailable`                              | Maximum number/percentage of pods that may be made unavailable                                                           | `""`                                                                                   |
| `nodeAffinityPreset.type`                         | Node affinity preset type. Ignored if `affinity` is set. Allowed values: `soft` or `hard`                                | `""`                                                                                   |
| `nodeAffinityPreset.key`                          | Node label key to match. Ignored if `affinity` is set                                                                    | `""`                                                                                   |
| `nodeAffinityPreset.values`                       | Node label values to match. Ignored if `affinity` is set                                                                 | `[]`                                                                                   |
| `affinity`                                        | Affinity for runtime-exporter pods assignment                                                                            | `{}`                                                                                   |
| `nodeSelector`                                    | Node labels for runtime-exporter pods assignment                                                                         | `{}`                                                                                   |
| `tolerations`                                     | Tolerations for runtime-exporter pods assignment                                                                         | `[]`                                                                                   |
| `updateStrategy.type`                             | runtime-exporter statefulset strategy type                                                                               | `RollingUpdate`                                                                        |
| `podManagementPolicy`                             | Statefulset Pod management policy, it needs to be Parallel to be able to complete the cluster join                       | `OrderedReady`                                                                         |
| `priorityClassName`                               | runtime-exporter pods' priorityClassName                                                                                 | `""`                                                                                   |
| `topologySpreadConstraints`                       | Topology Spread Constraints for pod assignment spread across your cluster among failure-domains. Evaluated as a template | `{}`                                                                                   |
| `schedulerName`                                   | Name of the k8s scheduler (other than default) for runtime-exporter pods                                                 | `""`                                                                                   |
| `terminationGracePeriodSeconds`                   | Seconds Redmine pod needs to terminate gracefully                                                                        | `""`                                                                                   |
| `lifecycleHooks`                                  | for the runtime-exporter container(s) to automate configuration before or after startup                                  | `{}`                                                                                   |
| `sidecars`                                        | Add additional sidecar containers to the runtime-exporter pod(s)                                                         | `{}`                                                                                   |
| `initContainers`                                  | Add additional init containers to the runtime-exporter pod(s)                                                            | `{}`                                                                                   |


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
| `serviceMonitor.endpoint.interval`            | Interval at which metrics should be scraped                      | `6s`       |
| `serviceMonitor.endpoint.scheme`              | HTTP scheme to use for scraping.                                 | `http`     |
| `serviceMonitor.endpoint.scrapeTimeout`       | Timeout after which the scrape is ended                          | `30s`      |
| `serviceMonitor.endpoint.honorLabels`         | Chooses the metric’s labels on collisions with target labels.    | `true`     |


  "rpcs": [
    "wss://rpc.polkadot.io",
    "wss://kusama-rpc.polkadot.io"
  ]
}
` |
| `runtimeExporter.prometheus.enabled`              | Enable exposing the prometheus port                                                                                      | `true`                                                                                 |
| `runtimeExporter.prometheus.port`                 | Set the prometheus port                                                                                                  | `8080`                                                                                 |
| `image.registry`                                  | runtime-exporter image registry                                                                                          | `docker.io`                                                                            |
| `image.repository`                                | runtime-exporter image repository                                                                                        | `paritytech/polkadot-runtime-prom-exporter`                                            |
| `image.tag`                                       | runtime-exporter image tag (immutable tags are recommended)                                                              | `latest`                                                                               |
| `image.pullPolicy`                                | runtime-exporter image pull policy                                                                                       | `IfNotPresent`                                                                         |
| `image.pullSecrets`                               | runtime-exporter image pull secrets                                                                                      | `[]`                                                                                   |
| `replicaCount`                                    | Number of runtime-exporter replicas to deploy                                                                            | `1`                                                                                    |
| `customLivenessProbe`                             | Custom livenessProbe that overrides the default one                                                                      | `{}`                                                                                   |
| `customReadinessProbe`                            | Custom readinessProbe that overrides the default one                                                                     | `{}`                                                                                   |
| `customStartupProbe`                              | Custom startupProbe that overrides the default one                                                                       | `{}`                                                                                   |
| `resources.limits`                                | The resources limits for the runtime-exporter containers                                                                 | `{}`                                                                                   |
| `resources.requests`                              | The requested resources for the runtime-exporter containers                                                              | `{}`                                                                                   |
| `podSecurityContext.enabled`                      | Enabled runtime-exporter pods' Security Context                                                                          | `true`                                                                                 |
| `podSecurityContext.fsGroup`                      | Set runtime-exporter pod's Security Context fsGroup                                                                      | `1001`                                                                                 |
| `containerSecurityContext.enabled`                | Enabled runtime-exporter containers' Security Context                                                                    | `true`                                                                                 |
| `containerSecurityContext.runAsUser`              | Set runtime-exporter containers' Security Context runAsUser                                                              | `1001`                                                                                 |
| `containerSecurityContext.runAsNonRoot`           | Set runtime-exporter containers' Security Context runAsNonRoot                                                           | `true`                                                                                 |
| `containerSecurityContext.readOnlyRootFilesystem` | Set runtime-exporter containers' Security Context runAsNonRoot                                                           | `false`                                                                                |
| `hostAliases`                                     | runtime-exporter pods host aliases                                                                                       | `[]`                                                                                   |
| `podLabels`                                       | Extra labels for runtime-exporter pods                                                                                   | `{}`                                                                                   |
| `podAnnotations`                                  | Annotations for runtime-exporter pods                                                                                    | `{}`                                                                                   |
| `podAffinityPreset`                               | Pod affinity preset. Ignored if `affinity` is set. Allowed values: `soft` or `hard`                                      | `""`                                                                                   |
| `podAntiAffinityPreset`                           | Pod anti-affinity preset. Ignored if `affinity` is set. Allowed values: `soft` or `hard`                                 | `soft`                                                                                 |
| `pdb.create`                                      | Enable/disable a Pod Disruption Budget creation                                                                          | `false`                                                                                |
| `pdb.minAvailable`                                | Minimum number/percentage of pods that should remain scheduled                                                           | `1`                                                                                    |
| `pdb.maxUnavailable`                              | Maximum number/percentage of pods that may be made unavailable                                                           | `""`                                                                                   |
| `nodeAffinityPreset.type`                         | Node affinity preset type. Ignored if `affinity` is set. Allowed values: `soft` or `hard`                                | `""`                                                                                   |
| `nodeAffinityPreset.key`                          | Node label key to match. Ignored if `affinity` is set                                                                    | `""`                                                                                   |
| `nodeAffinityPreset.values`                       | Node label values to match. Ignored if `affinity` is set                                                                 | `[]`                                                                                   |
| `affinity`                                        | Affinity for runtime-exporter pods assignment                                                                            | `{}`                                                                                   |
| `nodeSelector`                                    | Node labels for runtime-exporter pods assignment                                                                         | `{}`                                                                                   |
| `tolerations`                                     | Tolerations for runtime-exporter pods assignment                                                                         | `[]`                                                                                   |
| `updateStrategy.type`                             | runtime-exporter statefulset strategy type                                                                               | `RollingUpdate`                                                                        |
| `podManagementPolicy`                             | Statefulset Pod management policy, it needs to be Parallel to be able to complete the cluster join                       | `OrderedReady`                                                                         |
| `priorityClassName`                               | runtime-exporter pods' priorityClassName                                                                                 | `""`                                                                                   |
| `topologySpreadConstraints`                       | Topology Spread Constraints for pod assignment spread across your cluster among failure-domains. Evaluated as a template | `{}`                                                                                   |
| `schedulerName`                                   | Name of the k8s scheduler (other than default) for runtime-exporter pods                                                 | `""`                                                                                   |
| `terminationGracePeriodSeconds`                   | Seconds Redmine pod needs to terminate gracefully                                                                        | `""`                                                                                   |
| `lifecycleHooks`                                  | for the runtime-exporter container(s) to automate configuration before or after startup                                  | `{}`                                                                                   |
| `sidecars`                                        | Add additional sidecar containers to the runtime-exporter pod(s)                                                         | `{}`                                                                                   |
| `initContainers`                                  | Add additional init containers to the runtime-exporter pod(s)                                                            | `{}`                                                                                   |


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
| `serviceMonitor.endpoint.interval`            | Interval at which metrics should be scraped                      | `6s`       |
| `serviceMonitor.endpoint.scheme`              | HTTP scheme to use for scraping.                                 | `http`     |
| `serviceMonitor.endpoint.scrapeTimeout`       | Timeout after which the scrape is ended                          | `30s`      |
| `serviceMonitor.endpoint.honorLabels`         | Chooses the metric’s labels on collisions with target labels.    | `true`     |


