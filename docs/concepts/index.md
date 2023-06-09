# Concepts
The documentation in this section explains commonly referenced concepts and abstractions in RCS, providing a better understanding of how the Container-As-A-Service solution works.

## What is RCS?
RCS is an open-source implementation of Container-as-a-Service. It utilizes Knative and Open Cluster Management to create and manage workloads across multiple clusters, providing cloud-like features and technologies to offline environment users. RCS offers an auto cluster schedule based on cluster usage and availability, requires low configuration, and provides an auto-scaler template based on a single metric. With RCS, users can manage multiple revisions and custom DNS names, among other features. Overall, RCS aims to simplify and streamline the management of containerized applications, making it easier for developers to focus on writing code.

## What is Knative?
Knative is an open-source project used by RCS to build, deploy, and manage serverless workloads across multiple clusters. It provides a platform-agnostic solution for running serverless deployments, allowing RCS users to manage workloads with ease.

## Knative Serving
Knative Serving defines a set of Kubernetes Custom Resource Definitions (CRDs) that allow RCS users to define and control how their serverless workload behaves on the cluster. These resources include Services, Routes, Configurations, and Revisions, which manage the whole lifecycle of the workload. The Service resource automatically creates and manages other objects, ensuring that your app has a route, configuration, and a new revision for each update. The Route resource maps a network endpoint to one or more revisions, and the Configuration resource maintains the desired state for your deployment. The Revision resource is a point-in-time snapshot of the code and configuration for each modification made to the workload, and can be retained for as long as useful.

## Open-Cluster-Management
Open-Cluster-Management is a project used by RCS to manage Kubernetes clusters across multiple cloud providers and on-premises environments. It provides a centralized platform to manage clusters, applications, and policies, enabling RCS users to easily create and manage workloads on multiple clusters. With Open-Cluster-Management, RCS users can deploy, monitor, and scale their workloads, while also ensuring compliance and governance across all clusters.