# Generic Helm Chart

## Parameters

### General parameters

| Name                         | Description                                                         | Value          |
| ---------------------------- | ------------------------------------------------------------------- | -------------- |
| `nameOverride`               | A name to partially override .Chart.Name                            | `""`           |
| `fullnameOverride`           | a name to fully override resource naming                            | `""`           |
| `namespaceOverride`          | a the namespace to override the deployment namespace                | `""`           |
| `extraLabels`                | Additional common labels for resources                              | `{}`           |
| `image.repository`           | The image name to use                                               | `nginx`        |
| `image.pullPolicy`           | The pull policy to use for the image                                | `IfNotPresent` |
| `image.tag`                  | the tag to use for image                                            | `latest`       |
| `replicaCount`               | The number of replicas for the deployment/statefulSet               | `1`            |
| `imagePullSecrets`           | an array of the secrets to use when pulling an image                | `[]`           |
| `serviceAccount.create`      | Create a serviceAccount                                             | `true`         |
| `serviceAccount.annotations` | Annotations to use for the serviceAccount                           | `{}`           |
| `serviceAccount.name`        | the name to use for serviceAccount                                  | `""`           |
| `podAnnotations`             | Annotations to provide to the pod                                   | `{}`           |
| `podSecurityContext`         | Set the pod security context for the container                      | `{}`           |
| `containerSecurityContext`   | Set the container security context and capabilities                 | `{}`           |
| `env`                        | Environment variables to add to the pods                            | `{}`           |
| `envFrom`                    | Environment variables from secrets or configmaps to add to the pods | `[]`           |
| `additionalPodSpec`          | Additional pod spec                                                 | `{}`           |
| `secrets`                    | Create secrets (base64 encoded)                                     | `{}`           |
| `config`                     | Create a configmap resource                                         | `{}`           |
| `resources.limits`           | The resources limits for the containers                             | `{}`           |
| `resources.requests`         | The requested resources for the containers                          | `{}`           |
| `nodeSelector`               | Node labels for pods assignment                                     | `{}`           |
| `tolerations`                | Tolerations for pods assignment                                     | `[]`           |
| `affinity`                   | Affinity for pods assignment                                        | `{}`           |
| `podDisruptionBudget`        | the specification for the pod disruption budget                     | `{}`           |
| `extraVolumes`               | Extra volumes                                                       | `[]`           |
| `extraVolumeMounts`          | Mount extra volume(s)                                               | `[]`           |


### Service parameters

| Name                      | Description                                                                                   | Value       |
| ------------------------- | --------------------------------------------------------------------------------------------- | ----------- |
| `service.annotations`     | Add annotations to the service                                                                | `{}`        |
| `service.type`            | Type of service to use options are `ClusterIP`, `NodePort`, `LoadBalancer` and `ExternalName` | `ClusterIP` |
| `service.sessionAffinity` | Control where client requests go, to the same pod or round-robin (`ClientIP` or `None`)       | `""`        |
| `service.ports`           | Ports for the service to expose                                                               | `[]`        |


### Ingress parameters

| Name                  | Description                                                                                                                      | Value   |
| --------------------- | -------------------------------------------------------------------------------------------------------------------------------- | ------- |
| `ingress.enabled`     | Enable ingress record generation                                                                                                 | `false` |
| `ingress.className`   | IngressClass that will be be used to implement the Ingress (Kubernetes 1.18+)                                                    | `""`    |
| `ingress.annotations` | Additional annotations for the Ingress resource. To enable certificate autogeneration, place here your cert-manager annotations. | `{}`    |
| `ingress.hosts`       | An array with hostname(s) to be covered with the ingress record                                                                  | `[]`    |
| `ingress.tls`         | An array with the names of secrets to be assigned to the ingress records.                                                        | `[]`    |


### Probe parameters

| Name                                 | Description                              | Value |
| ------------------------------------ | ---------------------------------------- | ----- |
| `livenessProbe`                      | A livenessProbe                          | `{}`  |
| `livenessProbe.tcpSocket.port`       | Port for livenessProbe                   | `""`  |
| `livenessProbe.initialDelaySeconds`  | Initial delay seconds for livenessProbe  | `""`  |
| `livenessProbe.periodSeconds`        | Period seconds for livenessProbe         | `""`  |
| `livenessProbe.timeoutSeconds`       | Timeout seconds for livenessProbe        | `""`  |
| `livenessProbe.failureThreshold`     | Failure threshold for livenessProbe      | `""`  |
| `livenessProbe.successThreshold`     | Success threshold for livenessProbe      | `""`  |
| `readinessProbe`                     | a readinessProbe                         | `{}`  |
| `readinessProbe.tcpSocket.port`      | Port for readinessProbe                  | `""`  |
| `readinessProbe.initialDelaySeconds` | Initial delay seconds for readinessProbe | `""`  |
| `readinessProbe.periodSeconds`       | Period seconds for readinessProbe        | `""`  |
| `readinessProbe.timeoutSeconds`      | Timeout seconds for readinessProbe       | `""`  |
| `readinessProbe.failureThreshold`    | Failure threshold for readinessProbe     | `""`  |
| `readinessProbe.successThreshold`    | Success threshold for readinessProbe     | `""`  |
| `startupProbe`                       | a startupProbe                           | `{}`  |
| `startupProbe.tcpSocket.port`        | Port for startupProbe                    | `""`  |
| `startupProbe.initialDelaySeconds`   | Initial delay seconds for startupProbe   | `""`  |
| `startupProbe.periodSeconds`         | Period seconds for startupProbe          | `""`  |
| `startupProbe.timeoutSeconds`        | Timeout seconds for startupProbe         | `""`  |
| `startupProbe.failureThreshold`      | Failure threshold for startupProbe       | `""`  |
| `startupProbe.successThreshold`      | Success threshold for startupProbe       | `""`  |


### Statefulset and persistence parameters

| Name                           | Description                                           | Value               |
| ------------------------------ | ----------------------------------------------------- | ------------------- |
| `stateful.annotations`         | annotions to be used for the statefulSet              | `{}`                |
| `persistence.enabled`          | Enable persistence on the statefulSet's PVC           | `false`             |
| `persistence.accessModes`      | The statefulSets persistent volume claim access Modes | `["ReadWriteOnce"]` |
| `persistence.size`             | The statefulSets persistent volume claim size         | `50Gi`              |
| `persistence.annotations`      | the statefulSets persistent volume claim annotations  | `{}`                |
| `persistence.selector`         | Selector to match an existing Persistent Volume       | `{}`                |
| `persistence.subPath`          | Subdirectory of the volume to mount at                | `""`                |
| `persistence.existingClaim`    | Name of an existing `PersistentVolumeClaim` to use    | `""`                |
| `persistence.storageClassName` | Persistent volume storage Class Name to use           | `""`                |


### Autoscaling parameters

| Name                                            | Description                                                                      | Value   |
| ----------------------------------------------- | -------------------------------------------------------------------------------- | ------- |
| `autoscaling.enabled`                           | Whether enable horizontal pod autoscaler                                         | `false` |
| `autoscaling.minReplicas`                       | Configure a minimum amount of pods                                               | `1`     |
| `autoscaling.maxReplicas`                       | Configure a maximum amount of pods                                               | `100`   |
| `autoscaling.targetCPUUtilizationPercentage`    | Define the CPU target to trigger the scaling actions (utilization percentage)    | `80`    |
| `autoscaling.targetMemoryUtilizationPercentage` | Define the memory target to trigger the scaling actions (utilization percentage) | `""`    |


### Service-monitor parameters

| Name                         | Description                                                                                                               | Value   |
| ---------------------------- | ------------------------------------------------------------------------------------------------------------------------- | ------- |
| `serviceMonitor.enabled`     | if `true`, creates a Prometheus Operator ServiceMonitor                                                                   | `false` |
| `serviceMonitor.annotations` | ServiceMonitor annotations                                                                                                | `{}`    |
| `serviceMonitor.endpoints`   | The endpoint configuration of the ServiceMonitor. Path is mandatory. Interval, timeout and labellings can be overwritten. | `[]`    |


### CloudSQL parameters

| Name                          | Description                                                       | Value                                                           |
| ----------------------------- | ----------------------------------------------------------------- | --------------------------------------------------------------- |
| `cloudsql.enabled`            | if `true`, creates a cloudsql proxy deployment                    | `false`                                                         |
| `cloudsql.service.port`       | the port for the service to use                                   | `5432`                                                          |
| `cloudsql.service.targetPort` | the target port for the service to access the cloudsql deployment | `5432`                                                          |
| `cloudsql.commandline.args`   | additional arguments for the cloudsql startup command             | `-instances=gcp-project-id:zone:instance-name=tcp:0.0.0.0:5432` |

