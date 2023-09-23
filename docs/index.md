# Introduction

The documentation in this section explains commonly referenced concepts and abstractions in `Run Container Service` (`RCS`), providing a better understanding of how the Container-as-a-Service solution works.

## RCS

`RCS` is an open-source implementation of Container-as-a-Service. It leverages `Knative` and `Open Cluster Management` to create and manage workloads across multiple clusters, providing cloud-like features and technologies to offline environment users.

`RCS` offers automatic scheduling on of containerized workload on clusters, based on cluster usage and availability. It requires minimal configuration and provides an auto-scaler template based on a single metric. With `RCS`, users can manage multiple revisions and custom DNS names, among other features.

The unit of containerized workload is called `Capp` or `ContainerApp`.

Overall, `RCS` aims to simplify and streamline the management of containerized applications, making it easier for developers to focus on writing code.

## Open Cluster Management

`Open Cluster Management` (`OCM`) is a project used by `RCS` to manage a fleet of Kubernetes clusters across multiple cloud providers, suited also for on-premises environments.

It provides a centralized platform to manage clusters, applications, and policies, thus enabling `RCS` users to easily create and manage workloads on multiple clusters.

`OCM` uses a Hub-Spoke architecture: the Kubernetes cluster where `OCM` is installed is called a `Hub Cluster`, while the clusters that are connected to the `Hub Cluster` are called `Managed Clusters`.

With `OCM`, `RCS` users can deploy, monitor, and scale their workloads, while also ensuring compliance and governance across all clusters.

`RCS` takes advantage of `OCM`'s ability to do scheduling of workloads on clusters it manages based on certain criterias, thus allowing users to use a single endpoint for their deployments - that of the `Hub Cluster`, but having the actual workload run on one of the `Managed Clusters`. The `Hub Cluster` chooses the `Managed Cluster` which is the 'most suitable' to run the containized workload.

The `RCS` solution uses the `Placement` and `ManifestWork` APIs of the Open Cluster Management (OCM) project.

For more information please refer to the [OCM documentation](https://open-cluster-management.io/concepts/).

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

`Knative Serving` defines a set of Kubernetes Custom Resource Definitions (CRDs) that allow `RCS` users to define and control how their serverless workload behaves on the cluster. These resources include `Services`, `Routes`, `Configurations`, and `Revisions`, which manage the whole lifecycle of the workload:

- The `Service` resource automatically creates and manages other objects, ensuring that your app has a `Route`, `Configuration`, and a new `Revision` for each update.

- The `Route` resource maps a network endpoint to one or more revisions.

- The `Configuration` resource maintains the desired state for your deployment.

- The `Revision` resource is a point-in-time snapshot of the code and configuration for each modification made to the workload, and can be retained for as long as useful.

For more information, refer to the `Knative Serving` [docs](https://knative.dev/docs/serving/).

### Feature Highlights

- [x] Support for autoscaler (`HPA` or `KPA`) according to the chosen `scaleMetric` (`concurrency`, `rps`, `cpu`, `memory`) with default setting of `autoscaling.knative.dev/activation-scale: "3"`.
- [x] Support for HTTP/HTTPS `DomainMapping` for accessing applications via `Ingress`/`Route`.
- [x] Support for all `Knative Serving` configurations.
- [x] Support for exporting logs to `Elasticsearch` and `Splunk` indexes.

## Definitions

| #   | Term          | Synonym                   | Contextual Explanation                                                                        |
| --- | -------------| -------------------------| ----------------------------------------------------------------------------------------------|
| 1   | `RCS`           | Run Container Service     | The name of the overall in-house Container as a Service solution, which is separated to different components and different stages. |
| 2   | `Capp`          | Container App             | The name of the high-level API that is used by clients to deploy containerized workloads on remote clusters. |
| 3   | `ksvc`          | Knative Serving Service   | The name of the Knative Serving object used to deploy containerized workloads on Kubernetes clusters. |
| 4   | `Hub Cluster`   | OCM Cluster               | A centralized Kubernetes cluster used to manage a fleet of clusters and deploy containerized workload on them. |
| 5   | `Managed Cluster` | Infra Cluster           | An Kubernetes cluster used to run containerized workloads. |
| 6   | `Placement`     | -                         | An API available on the Hub Cluster that allows selecting the ‘most suitable’ Managed Cluster to deploy a containerized workload on. |
