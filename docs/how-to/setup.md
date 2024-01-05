# Setup

The documentation in this page explains how to setup `Capp` and `RCS` in your clusters.

## Prerequisites

The following should be installed on your Linux machine:

- [`KinD`](https://kind.sigs.k8s.io/docs/user/quick-start/)
- [`docker`](https://docs.docker.com/engine/install/)
- [`clusteradm`](https://github.com/open-cluster-management-io/clusteradm)
- [`kubectl`](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/)

The following should be installed on your Kubernetes clusters:

- [`cert-manager`](https://cert-manager.io/docs/installation/)

## Setup Capp

1. Clone the `container-app-operator` repository locally:

    ```bash
    git clone https://github.com/dana-team/container-app-operator.git
    cd container-app-operator
    ```

2. Run the following command:

    ```bash
    make prereq
    ```

    * This Makefile target installs the `Capp` CRD, installs `knative serving`, and installs `helm`, which is needed to install the `logging-operator`.

3. Run the following command:

    ```bash
    # replace the <release> with the release you wish to use
    make deploy IMG=ghcr.io/dana-team/container-app-operator:<release>
    ```

## Setup RCS

### Manual Installation

1. Clone the `rcs-ocm-deployer` repository locally:

    ```bash
    git clone https://github.com/dana-team/rcs-ocm-deployer
    ```

2. Clone the `OCM` repository locally:

    ```bash
    git clone https://github.com/open-cluster-management-io/OCM
    ```

3. Clone the `container-app-operator` repository locally:

    ```bash
    git clone https://github.com/dana-team/container-app-operator.git
    cd container-app-operator
    ```

4. Run the following commands:

    ```bash
    # run the OCM script to create 1 hub Kind cluster and 2 managed clusters with the following Kubernetes contexts: kind-hub, kind-cluster1, kind-cluster2
    ./OCM/solutions/setup-dev-environment/local-up.sh

    # install the Capp CRD to hub cluster
    kubectl config use-context kind-hub
    make -C container-app-operator install

    # deploy Capp on the Managed Clusters
    kubectl config use-context kind-cluster1
    make -C container-app-operator/ prereq
    make -C container-app-operator deploy IMG=ghcr.io/dana-team/container-app-operator:<release>

    kubectl config use-context kind-cluster2
    make -C container-app-operator/ prereq
    make -C container-app-operator deploy IMG=ghcr.io/dana-team/container-app-operator:<release>

    # cleanup
    rm -rf OCM
    rm -rf container-app-operator
    ```

### Using the rcs-quickstart script

1. Clone the `rcs-ocm-deployer` repository locally:

    ```bash
    git clone https://github.com/dana-team/rcs-ocm-deployer
    ```

2. Run:

    ```bash
    make quickstart
    ```

    * This Makefile target uses the `solutions/rcs-quickstart.sh` script found in the repo, and creates a `KinD` Hub Cluster and 2 `KinD` Managed Clusters with OCM and RCS installed.

### Setting Up the Hub Cluster

### Create ManagedClusterSet

`ManagedClusterSet` is an [OCM cluster-scoped API](https://open-cluster-management.io/concepts/managedclusterset/) in the Hub Cluster for grouping a few managed clusters into a "set".

1. To create a `ManagedClusterSet`, run the following command on the Hub Cluster:

    ```bash
    clusteradm create clusterset <clusterSet-name>
    ```

2. To add a Managed Cluster to the `ManagedClusterSet`, run the following command on the Hub Cluster:

    ```bash
    clusteradm clusterset set <clusterSet-name> --clusters <cluster-name>
    ```

3. To bind the cluster set to a namespace, run the following command on the Hub Cluster:

    ```bash
    clusteradm clusterset bind <clusterSet-name> --namespace <clusterSet-namespace>
    ```

### Create Placement

1. For the controller to work, it is needed to create a `Placement` CR.

    ```yaml
    apiVersion: cluster.open-cluster-management.io/v1beta1
    kind: Placement
    metadata:
    name: <placement-name>
    namespace: <clusterSet-namespace>
    spec:
    clusterSets:
        - <clusterSet-name>
    ```

### Create RCSConfig CR

The `rcs-ocm-deployer` operator utilizes the `RCSConfig` CRD to manage its configuration and deployment options.

A `RCSConfig` CR named `rcs-config` should exist in the `rcs-deployer-system` namespace. This CR instance contains the necessary configuration for the operator.

1. Create a CR which looks like this:

    ```yaml
    apiVersion: rcs.deployer.example.com/v1alpha1
    kind: RCSConfig
    metadata:
    name: rcs-config
    namespace: rcs-deployer-system
    spec:
    placements:
    - placement-1st
    - placement-2nd
    # Add more placement names as needed
    placementsNamespace: <your-placements-namespace>
    ```

    Ensure that the `.spec` section includes a list of `placements` and specifies the `placementsNamespace` as required for your setup.

- Note: In former releases, there were environment variables for the `placements` and `placementsNamespace`. However, please note that these environment variables have been deprecated and are no longer used.

### Deploy the controller

1. Run the following command:

    ```bash
    # replace the <release> with the release you wish to use
    make deploy IMG=ghcr.io/dana-team/rcs-ocm-deployer:<release>
    ```

### Deploy the add-on

1. Run the following command:

    ```bash
    make deploy-addon IMG=ghcr.io/dana-team/rcs-ocm-deployer:<release>
    ```
