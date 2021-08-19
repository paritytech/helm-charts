# Substrate Telemetry Helm Chart

The helm chart installs Telemetry-Core, Telemetry-Shard and Telemetry-Frontend services.  

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

