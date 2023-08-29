# Setup
The documentation in this page explains how to setup Capp and RCS in your cluster.

## Setup Capp
1. Clone the [repo](https://github.com/dana-team/container-app-operator)
2. Run `make prereq`
3. Run `make deploy IMG=danateam/container-app-operator:<IMG_TAG>` where IMG_TAG is the version you wish to use.

## Setup RCS
1. Clone the [repo](https://github.com/dana-team/rcs-ocm-deployer)
2. Install clusteradm cli
3. Run `clusteradm init --wait`
4. Use the following command in order to obtain the token for the managed clusters: `joincmd=$(clusteradm get token --context ${hubctx} | grep clusteradm)`
5. Run `make install deploy IMG=danateam/rcs-ocm-deployer:<IMG_TAG>`
6. Add the managed clusters using this command `$(echo ${joincmd} --force-internal-endpoint-lookup --wait --context <your_context> | sed "s/<cluster_name>/<<your_cluster_name>>/g")`
7. Accept the managed clusters into your hub using this command `clusteradm accept --context <hub_context> --clusters [cluster_names] --wait`


