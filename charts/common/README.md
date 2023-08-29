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
`helm-docs --chart-search-root=charts/common --template-files=README.md.gotmpl`

You may encounter `files were modified by this hook` error after updating README.md.gotmpl file when using pre-commit.
This is intended behaviour. Make sure to run `git add -A` once again to stage changes in the auto-updated REAMDE.md
-->

# Generic Helm Chart

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| additionalPodSpec | object | `{}` | Additional Pod Spec |
| affinity | object | `{}` | Assign custom affinity rules |
| args | list | `[]` | Override default container args |
| autoscaling | object | `{"enabled":false,"maxReplicas":100,"minReplicas":1,"targetCPUUtilizationPercentage":80}` | Autoscaling should be enabled for statefulsets ref: https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/ |
| autoscaling.enabled | bool | `false` | Enable autoscaling |
| autoscaling.maxReplicas | int | `100` | Maximum number of pods |
| autoscaling.minReplicas | int | `1` | Minimum number of pods |
| autoscaling.targetCPUUtilizationPercentage | int | `80` | Target CPU utilization percentage |
| cloudsql | object | `{"commandline":{"args":"-instances=gcp-project-id:zone:instance-name=tcp:0.0.0.0:5432"},"enabled":false,"service":{"port":5432,"targetPort":5432}}` | If enabled, create cloudsql proxy resources |
| command | list | `[]` | Override default container command |
| config | object | `{}` | Creates a configmap resource |
| containerSecurityContext | object | `{}` | SecurityContext settings for the main container |
| env | object | `{}` | Environment variable to add to the pods |
| envFrom | list | `[]` | Environment variables from secrets or configmaps to add to the pods |
| extraLabels | object | `{}` | Additional common labels on resources |
| extraVolumeMounts | list | `[]` | Extra volume mounts together. Corresponds to `extraVolumes`. |
| extraVolumes | list | `[]` | Extra volumes to be added in addition to those specified under `defaultVolumes`. |
| fullnameOverride | string | `""` | Provide a name to substitute for the full names of resources |
| image | object | `{"pullPolicy":"IfNotPresent","repository":"nginx","tag":"latest"}` | Image to use for the chart |
| image.pullPolicy | string | `"IfNotPresent"` | Image pull policy |
| image.repository | string | `"nginx"` | Image repository |
| image.tag | string | `"latest"` | Image tag |
| imagePullSecrets | list | `[]` | Reference to one or more secrets to be used when pulling images ref: https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/ |
| ingress | object | `{"annotations":{},"className":"","enabled":false,"hosts":[{"host":"chart-example.local","paths":[{"path":"/","pathType":"ImplementationSpecific"}]}],"tls":[{"hosts":["chart-example.local"],"secretName":"chart-example-tls"}]}` | Creates an ingress resource |
| ingress.annotations | object | `{}` | Annotations to add to the Ingress |
| ingress.className | string | `""` | Ingress class name |
| ingress.enabled | bool | `false` | Enable creation of Ingress |
| ingress.hosts | list | `[{"host":"chart-example.local","paths":[{"path":"/","pathType":"ImplementationSpecific"}]}]` | A list of hosts for the Ingress |
| ingress.tls | list | `[{"hosts":["chart-example.local"],"secretName":"chart-example-tls"}]` | Ingress TLS configuration |
| ingress.tls[0] | object | `{"hosts":["chart-example.local"],"secretName":"chart-example-tls"}` | Secrets to use for TLS configuration |
| ingress.tls[0].hosts | list | `["chart-example.local"]` | A list of hosts for the Ingress with TLS enabled |
| livenessProbe | object | `{}` | Controller Container liveness probe configuration ref: https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/ |
| nameOverride | string | `""` | Provide a name in place of node for `app:` labels |
| namespaceOverride | string | `""` | Provide a name to substitute for the full names of resources |
| nodeSelector | object | `{}` | Define which Nodes the Pods are scheduled on. |
| persistence | object | `{"accessModes":["ReadWriteOnce"],"annotations":{},"enabled":false,"size":"50Gi"}` | If enabled, creates a PVC and deploy the pod as statefulset |
| persistence.accessModes | list | `["ReadWriteOnce"]` | PVC access mode |
| persistence.annotations | object | `{}` | Annotations to add to the PVC |
| persistence.enabled | bool | `false` | Enable PVC creation |
| persistence.size | string | `"50Gi"` | PVC storage size |
| podAnnotations | object | `{}` | Annotations to add to the pod |
| podDisruptionBudget | object | `{}` | See `kubectl explain poddisruptionbudget.spec` for more ref: https://kubernetes.io/docs/tasks/run-application/configure-pdb/ |
| podSecurityContext | object | `{}` | SecurityContext holds pod-level security attributes and common container settings. This defaults to non root user with uid 1000 and gid 1000. ref: https://kubernetes.io/docs/tasks/configure-pod-container/security-context/ |
| readinessProbe | object | `{}` | Controller Container readiness probe configuration |
| replicaCount | int | `1` | Number of replicas for the pod |
| resources | object | `{}` | Resource limits & requests |
| secrets | object | `{}` | Creates a secret resource The value must be base64 encoded |
| service | object | `{"annotations":{},"ports":null,"sessionAffinity":"","type":"ClusterIP"}` | Creates a service resource |
| service.annotations | object | `{}` | Annotations to add to the Service resource |
| service.ports | string | `nil` | Ports to expose on the service |
| service.sessionAffinity | string | `""` | Session Affinitiy type |
| service.type | string | `"ClusterIP"` | Service type |
| serviceAccount | object | `{"annotations":{},"create":true,"name":""}` | Service account for the pod to use ref: https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/ |
| serviceAccount.name | string | `""` | The name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| serviceMonitor | object | `{"annotations":{},"enabled":false,"endpoints":[{"honorLabels":true,"interval":"1m","path":"/metrics","port":"http","scheme":"http","scrapeTimeout":"30s"}],"targetLabels":[]}` | If enabled, create service monitor of Prometheus-Operator ref: https://github.com/prometheus-operator/prometheus-operator/blob/main/Documentation/user-guides/getting-started.md#include-servicemonitors |
| serviceMonitor.annotations | object | `{}` | Annotations to assign to the ServiceMonitor |
| serviceMonitor.enabled | bool | `false` | Enables Service Monitor |
| serviceMonitor.endpoints | list | `[{"honorLabels":true,"interval":"1m","path":"/metrics","port":"http","scheme":"http","scrapeTimeout":"30s"}]` | List of endpoints of service which Prometheus scrapes |
| serviceMonitor.targetLabels | list | `[]` | Propagate certain service labels to Prometheus. |
| startupProbe | object | `{}` | Controller Container startup probe configuration |
| stateful | object | `{"annotations":{}}` | Annotations to add to the pod of statefulset |
| tolerations | list | `[]` | Tolerations for use with node taints |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.11.0](https://github.com/norwoodj/helm-docs/releases/v1.11.0)
