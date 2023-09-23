# Setup
The documentation in this page explains how to setup Capp and RCS in your cluster.

## Setup Capp
After cloning the [repo](https://github.com/dana-team/container-app-operator), run the following commands:
```
make prereq
#replace <IMG_TAG> with the version you wish to use
make deploy IMG=danateam/container-app-operator:<IMG_TAG>
```
The `make prereq` directive installs the capp CRD, installs `knative serving`, and helm in order to install the `logging-operator`.

## Setup RCS
### Manual Installation
After cloning the [repo](https://github.com/dana-team/rcs-ocm-deployer), cloning [OCM](git clone https://github.com/open-cluster-management-io/OCM) and [capp](https://github.com/dana-team/container-app-operator) and downloading the [clusteradm](https://github.com/open-cluster-management-io/clusteradm) cli, run the follwing commands:
```
# Running the OCM script to create 1 hub Kind cluster and 2 managed clusters
./OCM/solutions/setup-dev-environment/local-up.sh
# Install capp crd to hub cluster
kubectl config use-context kind-hub
make -C container-app-operator install

# Deploy capp to managed clusters
kubectl config use-context kind-cluster1
make -C container-app-operator/ prereq
make -C container-app-operator deploy IMG=danateam/container-app-operator:<IMG_TAG>
kubectl config use-context kind-cluster2
make -C container-app-operator/ prereq
make -C container-app-operator deploy IMG=danateam/container-app-operator:<IMG_TAG>

# Cleanup
rm -rf OCM
rm -rf container-app-operator

```

### Using the rcs-quickstart script
Install [clusteradm](https://github.com/open-cluster-management-io/clusteradm) and clone the [rcs-ocm-deployer](https://github.com/dana-team/rcs-ocm-deployer) repo, and run:
```
make quickstart
```
This Makefile directive uses the solutions/rcs-quickstart.sh script found and repo, and it creates a kind hub cluster and 2 managed kind clusters with OCM and RCS installed.



