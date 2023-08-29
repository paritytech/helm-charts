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
`helm-docs --chart-search-root=charts/substrate-telemetry --template-files=README.md.gotmpl`

You may encounter `files were modified by this hook` error after updating README.md.gotmpl file when using pre-commit.
This is intended behaviour. Make sure to run `git add -A` once again to stage changes in the auto-updated REAMDE.md
-->

# Substrate Telemetry Helm Chart

The helm chart installs Telemetry-Core, Telemetry-Shard and Telemetry-Frontend services.

![Version: 2.3.1](https://img.shields.io/badge/Version-2.3.1-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.16.0](https://img.shields.io/badge/AppVersion-1.16.0-informational?style=flat-square)

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| Parity | <devops+helm@parity.io> | <https://github.com/paritytech/helm-charts> |

Substrate-Telemetry Github repo lives in https://github.com/paritytech/substrate-telemetry.

## Installing the chart

```console
helm repo add parity https://paritytech.github.io/helm-charts/
helm repo update
helm install substrate-telemetry parity/substrate-telemetry
```

## Requirements
By default, the type of Kubernetes service used for Telemetry-Core, Telemetry-Shard and Telemetry-Frontend is `ClusterIP`, so they're not accessible from outside of the k8s cluster. Consider exposing all of the services using service of type `LoadBalancer` or using an ingress controller:
  - **Frontend**: This is the frontend web application for the backend services.
  - **Shard**: Polkadot/Substrate nodes will submit their statistics to the `/submit` endpoint of the `Shard` service. It's recommended to only expose `/submit` endpoint.
  - **Core**: This is where all of the data would be stored. The `/feed` should only be exposed to the public network as other endpoints might expose sensitive information about the nodes.

**Notes**:
- All the services must be exposed over `HTTPS`.
- The `Core` service could also be exposed using the `Frontend` Nginx service. The Nginx configuration should be tweaked for this purpose.
- Consider setting `.Values.envVars.frontend.SUBSTRATE_TELEMETRY_URL` variable otherwise the web clients wouldn't be able to find the `Core` service address.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` | Assign custom affinity rules |
| autoscaling | object | `{"core":{"enabled":false},"frontend":{"enabled":false,"maxReplicas":6,"minReplicas":1,"targetCPUUtilizationPercentage":80},"shard":{"enabled":false,"maxReplicas":6,"minReplicas":2,"targetCPUUtilizationPercentage":80}}` | Autoscaling configuration |
| autoscaling.core | object | `{"enabled":false}` | Autoscaling configuration for the Core service |
| autoscaling.core.enabled | bool | `false` | Enables autoscaling |
| autoscaling.frontend | object | `{"enabled":false,"maxReplicas":6,"minReplicas":1,"targetCPUUtilizationPercentage":80}` | Autoscaling configuration for the Frontend service |
| autoscaling.frontend.enabled | bool | `false` | Enables autoscaling |
| autoscaling.frontend.maxReplicas | int | `6` | Maximum number of replicas |
| autoscaling.frontend.minReplicas | int | `1` | Minimum number of replicas |
| autoscaling.frontend.targetCPUUtilizationPercentage | int | `80` | Target CPU utilization percentage |
| autoscaling.shard | object | `{"enabled":false,"maxReplicas":6,"minReplicas":2,"targetCPUUtilizationPercentage":80}` | Autoscaling configuration for the Shard service NOTE: The core service is not scalable at the moment. |
| autoscaling.shard.enabled | bool | `false` | Enables autoscaling |
| autoscaling.shard.maxReplicas | int | `6` | Maximum number of replicas |
| autoscaling.shard.minReplicas | int | `2` | Minimum number of replicas |
| autoscaling.shard.targetCPUUtilizationPercentage | int | `80` | Target CPU utilization percentage |
| envVars | object | `{"core":{},"frontend":{"SUBSTRATE_TELEMETRY_URL":"wss://core-service-domain.com"},"shard":{}}` | Environment variables to set on the main containers |
| envVars.core | object | `{}` | Environment variables to set on the core service |
| envVars.frontend | object | `{"SUBSTRATE_TELEMETRY_URL":"wss://core-service-domain.com"}` | Environment variables to set on the frontend service |
| envVars.frontend.SUBSTRATE_TELEMETRY_URL | string | `"wss://core-service-domain.com"` | The frontend docker container makes this available to the UI, so that it knows where to look for feed information: |
| envVars.shard | object | `{}` | Environment variables to set on the shard service |
| extraArgs | object | `{"core":{},"shard":{}}` | Extra arguments to pass to the services |
| extraArgs.core | object | `{}` | Extra arguments to pass to the core service |
| extraArgs.shard | object | `{}` | Extra arguments to pass to the shard service |
| fullnameOverride | string | `""` | Provide a name to substitute for the full names of resources |
| image | object | `{"backend":{"pullPolicy":"IfNotPresent","repository":"docker.io/parity/substrate-telemetry-backend","tag":"latest"},"frontend":{"pullPolicy":"IfNotPresent","repository":"docker.io/parity/substrate-telemetry-frontend","tag":"latest"}}` | Image to use for the service |
| image.backend | object | `{"pullPolicy":"IfNotPresent","repository":"docker.io/parity/substrate-telemetry-backend","tag":"latest"}` | Image for the backend service |
| image.backend.pullPolicy | string | `"IfNotPresent"` | Image pull policy |
| image.backend.repository | string | `"docker.io/parity/substrate-telemetry-backend"` | Image repository |
| image.backend.tag | string | `"latest"` | Image tag |
| image.frontend | object | `{"pullPolicy":"IfNotPresent","repository":"docker.io/parity/substrate-telemetry-frontend","tag":"latest"}` | Image for the frontend service |
| image.frontend.pullPolicy | string | `"IfNotPresent"` | Image pull policy |
| image.frontend.repository | string | `"docker.io/parity/substrate-telemetry-frontend"` | Image repository |
| image.frontend.tag | string | `"latest"` | Image tag |
| imagePullSecrets | list | `[]` | Reference to one or more secrets to be used when pulling images. ref: https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/ |
| ingress | object | `{"core":{"annotations":{},"className":"","enabled":false,"rules":[{"host":"feed.example.local","http":{"paths":[{"backend":{"service":{"name":"telemetry-core","port":{"number":80}}},"path":"/feed","pathType":"Exact"},{"backend":{"service":{"name":"telemetry-core","port":{"number":80}}},"path":"/feed/","pathType":"Exact"}]}}],"tls":[{"hosts":["feed.example.local"],"secretName":"feed.example.local"}]},"frontend":{"annotations":null,"className":"","enabled":false,"rules":[{"host":"example.local","http":{"paths":[{"backend":{"service":{"name":"telemetry-frontend","port":{"number":80}}},"path":"/","pathType":"Prefix"}]}}],"tls":[{"hosts":["example.local"],"secretName":"example.local"}]},"shard":{"annotations":{},"className":"","enabled":false,"rules":[{"host":"shard.example.local","http":{"paths":[{"backend":{"service":{"name":"telemetry-shard","port":{"number":80}}},"path":"/submit","pathType":"Exact"},{"backend":{"service":{"name":"telemetry-shard","port":{"number":80}}},"path":"/submit/","pathType":"Exact"}]}}],"tls":[{"hosts":["shard.example.local"],"secretName":"shard.example.local"}]}}` | Creates an ingress resource |
| ingress.core | object | `{"annotations":{},"className":"","enabled":false,"rules":[{"host":"feed.example.local","http":{"paths":[{"backend":{"service":{"name":"telemetry-core","port":{"number":80}}},"path":"/feed","pathType":"Exact"},{"backend":{"service":{"name":"telemetry-core","port":{"number":80}}},"path":"/feed/","pathType":"Exact"}]}}],"tls":[{"hosts":["feed.example.local"],"secretName":"feed.example.local"}]}` | Ingress configuration for the Core service |
| ingress.core.annotations | object | `{}` | Annotations to add to the Ingress |
| ingress.core.className | string | `""` | Ingress class name |
| ingress.core.enabled | bool | `false` | Enable Ingress for the Core service |
| ingress.core.rules | list | `[{"host":"feed.example.local","http":{"paths":[{"backend":{"service":{"name":"telemetry-core","port":{"number":80}}},"path":"/feed","pathType":"Exact"},{"backend":{"service":{"name":"telemetry-core","port":{"number":80}}},"path":"/feed/","pathType":"Exact"}]}}]` | A list of hosts for the Ingress |
| ingress.core.tls | list | `[{"hosts":["feed.example.local"],"secretName":"feed.example.local"}]` | Ingress TLS configuration |
| ingress.core.tls[0] | object | `{"hosts":["feed.example.local"],"secretName":"feed.example.local"}` | Secret name for the TLS certificate |
| ingress.core.tls[0].hosts | list | `["feed.example.local"]` | A list of hosts for the Ingress with TLS enabled |
| ingress.frontend | object | `{"annotations":null,"className":"","enabled":false,"rules":[{"host":"example.local","http":{"paths":[{"backend":{"service":{"name":"telemetry-frontend","port":{"number":80}}},"path":"/","pathType":"Prefix"}]}}],"tls":[{"hosts":["example.local"],"secretName":"example.local"}]}` | Ingress configuration for the Frontend service |
| ingress.frontend.annotations | string | `nil` | Annotations to add to the Ingress |
| ingress.frontend.className | string | `""` | Ingress class name |
| ingress.frontend.enabled | bool | `false` | Enable Ingress for the Frontend service |
| ingress.frontend.rules | list | `[{"host":"example.local","http":{"paths":[{"backend":{"service":{"name":"telemetry-frontend","port":{"number":80}}},"path":"/","pathType":"Prefix"}]}}]` | A list of hosts for the Ingress |
| ingress.frontend.tls | list | `[{"hosts":["example.local"],"secretName":"example.local"}]` | Ingress TLS configuration |
| ingress.frontend.tls[0] | object | `{"hosts":["example.local"],"secretName":"example.local"}` | Secret name for the TLS certificate |
| ingress.frontend.tls[0].hosts | list | `["example.local"]` | A list of hosts for the Ingress with TLS enabled |
| ingress.shard | object | `{"annotations":{},"className":"","enabled":false,"rules":[{"host":"shard.example.local","http":{"paths":[{"backend":{"service":{"name":"telemetry-shard","port":{"number":80}}},"path":"/submit","pathType":"Exact"},{"backend":{"service":{"name":"telemetry-shard","port":{"number":80}}},"path":"/submit/","pathType":"Exact"}]}}],"tls":[{"hosts":["shard.example.local"],"secretName":"shard.example.local"}]}` | Ingress configuration for the Shard service |
| ingress.shard.annotations | object | `{}` | Annotations to add to the Ingress |
| ingress.shard.className | string | `""` | Ingress class name |
| ingress.shard.enabled | bool | `false` | Enable Ingress for the Shard service |
| ingress.shard.rules | list | `[{"host":"shard.example.local","http":{"paths":[{"backend":{"service":{"name":"telemetry-shard","port":{"number":80}}},"path":"/submit","pathType":"Exact"},{"backend":{"service":{"name":"telemetry-shard","port":{"number":80}}},"path":"/submit/","pathType":"Exact"}]}}]` | A list of hosts for the Ingress |
| ingress.shard.tls | list | `[{"hosts":["shard.example.local"],"secretName":"shard.example.local"}]` | Ingress TLS configuration |
| ingress.shard.tls[0] | object | `{"hosts":["shard.example.local"],"secretName":"shard.example.local"}` | Secret name for the TLS certificate |
| ingress.shard.tls[0].hosts | list | `["shard.example.local"]` | A list of hosts for the Ingress with TLS enabled |
| nameOverride | string | `""` | Provide a name in place of node for `app:` labels |
| nodeSelector | object | `{}` | Define which Nodes the Pods are scheduled on |
| podAnnotations | object | `{}` | Annotations to add to the Pod |
| podSecurityContext | object | `{}` | SecurityContext holds pod-level security attributes and common container settings. ref: https://kubernetes.io/docs/tasks/configure-pod-container/security-context/ |
| replicaCount | object | `{"core":1,"frontend":1,"shard":1}` | Number of replicas to deploy |
| replicaCount.core | int | `1` | Number of Core service replicas |
| replicaCount.frontend | int | `1` | Number of Frontend service replicas |
| replicaCount.shard | int | `1` | Number of Shard service replicas NOTE: The core service is not scalable at the moment. |
| resources | object | `{"core":{},"frontend":{},"shard":{}}` | Resource limits & requests |
| resources.core | object | `{}` | Resource limits & requests for the Core service |
| resources.frontend | object | `{}` | Resource limits & requests for the Frontend service |
| resources.shard | object | `{}` | Resource limits & requests for the Shard service |
| securityContext | object | `{}` | SecurityContext settings |
| service | object | `{"core":{"annotations":{},"port":80,"targetPort":8000,"type":"ClusterIP"},"frontend":{"annotations":{},"port":80,"targetPort":8000,"type":"ClusterIP"},"shard":{"annotations":{},"port":80,"targetPort":8000,"type":"ClusterIP"}}` | Configration of the Service |
| service.core | object | `{"annotations":{},"port":80,"targetPort":8000,"type":"ClusterIP"}` | Configration of the Service for the Core service |
| service.core.annotations | object | `{}` | Additional annotations to assign to the Service object |
| service.core.port | int | `80` | Service port to expose |
| service.core.targetPort | int | `8000` | A port of the service where the traffic is forwarded |
| service.core.type | string | `"ClusterIP"` | Service type |
| service.frontend | object | `{"annotations":{},"port":80,"targetPort":8000,"type":"ClusterIP"}` | Configration of the Service for the Frontend service |
| service.frontend.annotations | object | `{}` | Additional annotations to assign to the Service object |
| service.frontend.port | int | `80` | Service port to expose |
| service.frontend.targetPort | int | `8000` | A port of the service where the traffic is forwarded |
| service.frontend.type | string | `"ClusterIP"` | Service type |
| service.shard | object | `{"annotations":{},"port":80,"targetPort":8000,"type":"ClusterIP"}` | Configration of the Service for the Shard service |
| service.shard.annotations | object | `{}` | Additional annotations to assign to the Service object |
| service.shard.port | int | `80` | Service port to expose |
| service.shard.targetPort | int | `8000` | A port of the service where the traffic is forwarded |
| service.shard.type | string | `"ClusterIP"` | Service type |
| serviceAccount | object | `{"annotations":{},"create":true,"name":""}` | Service account for the node to use. ref: https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/ |
| serviceAccount.annotations | object | `{}` | Annotations to add to the Service Account |
| serviceAccount.create | bool | `true` | Enable creation of a Service Account for the main container |
| serviceAccount.name | string | `""` | The name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| serviceMonitor | object | `{"core":{"additionalLabels":{},"annotations":{},"enabled":false,"interval":"","scrapeTimeout":"10s"}}` | Service Monitor of Prometheus-Operator ref: https://github.com/prometheus-operator/prometheus-operator/blob/main/Documentation/user-guides/getting-started.md#include-servicemonitors |
| serviceMonitor.core | object | `{"additionalLabels":{},"annotations":{},"enabled":false,"interval":"","scrapeTimeout":"10s"}` | Expose ServiceMonitor on the core service Only core service has Prometheus metrics exposed at the moment. |
| serviceMonitor.core.additionalLabels | object | `{}` | Additional labels to assign to the ServiceMonitor |
| serviceMonitor.core.annotations | object | `{}` | Annotations to assign to the ServiceMonitor |
| serviceMonitor.core.enabled | bool | `false` | Enables Service Monitor |
| serviceMonitor.core.interval | string | `""` | Scrape interval |
| serviceMonitor.core.scrapeTimeout | string | `"10s"` | Scrape timeout |
| tolerations | list | `[]` | Tolerations for use with node taints |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.11.0](https://github.com/norwoodj/helm-docs/releases/v1.11.0)
