# Motivations

In this section we will briefly explain the reasons that make `RCS` needed in the on-premise landscape.

## Namespace as a Service

The motivations all largely circle around the fact that `Namespace as a Service` is a failing multi-tenancy model for a large organization. The concept of shared clusters and the multi-tenancy model of `Namespace as a Service` raises several difficulties both in how the Kubernetes service is consumed and in how it is managed.

Note that the `RCS` solution does not solve this problem on its own, but rather lives alongside the `RKS` (`Run Kubernetes Service`) solution that is out of the scope of this document. In a world with `RCS` and `RKS`, however, the model of `NSaaS` is obsolete and is replaced by multi-tenancy models that are in line with what exists in the Public Cloud.

### A Cloud experience

The solutions that exist in the Cloud (Azure, AWS and Google Cloud to name a few) are all in line with `RCS` and `RKS` as solutions: Azure has `Container Apps` and `AKS`, Amazon has `ECS` and `Fargate`, and `Google Cloud` has `Google Cloud Run` and `GKE`.

No cloud actually offers a `Namespace as a Service` model. This model is more prevalent in start-ups and small enterprises.

This strengthens the notion that most if not all use-cases that are in place with a `NSaaS` model can be achieved through the `RCS` and `RKS` model, since this is what exists in the cloud.

## Resource Management

Resource Management differs from one implementation to the other in on-premise environments. In environments where a Wallets-based solution is in play, and Resource Management and becoming more resource-efficient is at large at the hands of end-users, the reality often shows that resources are being poorly managed.

Often deployments contain a much higher request of resources than what is actually utilized by the application and many resources are being wasted due to Kubernetes’ Thick Provisioning model of resources which guarantees resources as per the request.

A new model is required to better utilize the resources of the cluster and `RCS` proposes a solution to this problem as well through the built-in Autoscale API.

## Standardization

In many on-premise environments there is no standard enforced for how applications are deployed. With `RCS` in play, it is possible to make sure all applications look exactly in the same way, which would make debugging and collecting information on the applications much easier.

In addition, it would be possible to make sure that applications are never deployed with a single replica, without using a third-party Policy Engine such as `Kyverno` or `OPA`.

## Multi Site

Deploying workloads on two separate sites, or even two separate Kubernetes clusters in the same site, requires having sufficient resources in 2 different Wallets (one for each site, assuming a Wallet-like implementation is used), going two 2 different UIs (or logging to 2 different Kubernetes clusters through `kubectl`), and then deploying the workload.

`RCS` proposes a way to make this much easier for the end users and having the user face only a single interface and choose whether it’s needed to deploy the application on multiple sites or not.

## Many Concepts to Learn

To deploy and debug workload on shared clusters in a mostly self-sufficient way, one must have at least a basic understanding of Kubernetes concepts.

Even if you want to deploy (and manage!) a simple UI application on Kubernetes, you still need to understand what Deployments are, what Pods are, what Ingress are, etc...

This is quite a bit of learning for a use case that does not really require it.

There are those who choose to never learn these concepts but they find themselves relying on the Cluster Admins for assistance even in the simplest of things.
