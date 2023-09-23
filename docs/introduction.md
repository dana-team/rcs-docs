# Introduction

## RCS

`RCS` (Run Container Service) is an open-source implementation of Container as a Service solution.

It utilizes the `OCM` project to create and manage workloads across multiple Kubernetes clusters, providing cloud-like features and technologies to users running on-premise.

It offers an auto cluster scheduler based on cluster usage and availability, requires basic configuration, and provides an auto-scaler template based on a single metric, among other features.

`RCS` aims to simplify and streamline the management of containerized applications, making it easier for developers to focus on writing code.

## Open Cluster Management

The `RCS` solution uses the `Placement` and `ManifestWork` APIs of the Open Cluster Management (OCM) project. For more information please refer to the [OCM documentation](https://open-cluster-management.io/concepts/).

### rcs-ocm-deployer

[`rcs-ocm-deployer`](https://github.com/dana-team/rcs-ocm-deployer) is a Kubernetes operator designed to deploy `Capp` (ContainerApp) workloads created on the Hub Cluster on the most suitable Managed Cluster using `OCM` (Open Cluster Management) APIs of `Placement` and `ManifestWork`. It also includes a `OCM AddOn` to sync the status of `Capp` between the Managed Clusters and the Hub Cluster.

## Capp

`Capp` (or ContainerApp) provides a higher-level abstraction for deploying containerized workload, making it easier for end-users to deploy workloads on Kubernetes without being knowledgeable in Kubernetes concepts, while adhering to the standards required by the infrastructure and platform teams without any extra burden on the users.

The operator uses open-source projects, such as [`Knative Serving`](https://github.com/knative/serving) and [`logging-operator`](https://github.com/kube-logging/logging-operator) to create an abstraction for containerized workloads.

### container-app-operator

[`container-app-operator`](https://github.com/dana-team/container-app-operator) is an operator that reconciles `Capp` CRs. The project can work as a standalone solution, but is mostly used together with the [`rcs-ocm-deployer`](https://github.com/dana-team/rcs-ocm-deployer), which allows deploying `Capp` workloads in a multi-cluster set-up, using the `OCM` (Open Cluster Management) open-source project.

#### What is Knative?

`Knative` is an open-source project used by RCS to build, deploy, and manage serverless workloads across multiple clusters. It provides a platform-agnostic solution for running serverless deployments, allowing `RCS` users to manage workloads with ease.

#### Knative Serving

`Knative Serving` defines a set of Kubernetes Custom Resource Definitions (CRDs) that allow `RCS` users to define and control how their serverless workload behaves on the cluster. 

These resources include `Services`, `Routes`, `Configurations`, and `Revisions`, which manage the whole lifecycle of the workload. For more information, refer to the `Knative Serving` [docs](https://knative.dev/docs/serving/).

### Feature Highlights

- [x] Support for autoscaler (`HPA` or `KPA`) according to the chosen `scaleMetric` (`concurrency`, `rps`, `cpu`, `memory`) with default setting of `autoscaling.knative.dev/activation-scale: "3"`.
- [x] Support for HTTP/HTTPS `DomainMapping` for accessing applications via `Ingress`/`Route`.
- [x] Support for all `Knative Serving` configurations.
- [x] Support for exporting logs to `Elasticsearch` and `Splunk` indexes.
