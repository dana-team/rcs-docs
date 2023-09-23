# Capp Health

How to know if `Capp` is currently healthy or non-healthy?

The `Capp` status is composed of a few parts. In this doc we will look into two of them: `Revisions` and `knativeObjectStatus`.

## knativeObjectStatus

### Example

```yaml
status:
...
    knativeObjectStatus:
      address:
        url: http://capp-with-cluster.capp-tests.svc.cluster.local
      conditions:
      - lastTransitionTime: "2023-08-07T07:58:00Z"
        status: "True"
        type: ConfigurationsReady
      - lastTransitionTime: "2023-08-07T08:07:52Z"
        status: "True"
        type: Ready
      - lastTransitionTime: "2023-08-07T08:07:52Z"
        status: "True"
        type: RoutesReady
      latestCreatedRevisionName: capp-with-cluster-00003
      latestReadyRevisionName: capp-with-cluster-00003
      observedGeneration: 3
      traffic:
      - latestRevision: true
        percent: 100
        revisionName: capp-with-cluster-00003
      url: https://capp-with-cluster-capp-tests.apps.ocp-rcs-managed-1.os-pub.com
...
```

### knativeObjectStatus Explanation

- `latestReadyRevisionName`: Holds the name of the latest `Revision` stamped out from this `Configuration` that's had its `Ready` condition become `True`.

- `traffic`: Holds the configured traffic distribution. These entries will always contain `RevisionName` references.

#### knativeObjectStatus Conditions

`ConfigurationsReady`: Set to `True` when the service's underlying configurations have reported readiness.

- `Ready`: Set when all the revisions are starting to materialize runtime resources, and becomes `True` when those resources are ready.

- `RoutesReady`: Set to `True` when the underlying routes for all components have reported readiness.

## Revisions

### Example

```yaml
 status:
 ...
    Revisions:
      - RevisionsStatus:
        actualReplicas: 2
        conditions:
        - lastTransitionTime: "2023-08-06T14:21:23Z"
          severity: Info
          status: "True"
          type: Active
        - lastTransitionTime: "2023-08-06T14:21:23Z"
          status: "True"
          type: ContainerHealthy
        - lastTransitionTime: "2023-08-06T14:21:23Z"
          status: "True"
          type: Ready
        - lastTransitionTime: "2023-08-06T14:21:23Z"
          status: "True"
          type: ResourcesAvailable
        containerStatuses:
        name: capp-with-cluster
        desiredReplicas: 2
        observedGeneration: 1
      name: capp-with-cluster-00001
...
```

### Revisions Explanation

- `ActualReplicas`: The number of `Ready` pods running this revision.

- `DesiredReplicas`: The desired number of pods running this revision.

#### Revisions Conditions

- `Ready`: Set when the revision is starting to materialize runtime resources, and is set to `True` when those resources are ready.

- `ResourceAvailable`: Set to `True` when underlying Kubernetes resources have been provisioned.

- `Active`: Set to `True` when the revision is receiving traffic.

- `ContainerHealthy`: Set to `True` when the revision readiness check completes.

## Conclusion

We can consider `Capp` healthy if:

1. It has the `Ready` condition inside the `knativeObjectStatus` set to `True`.

2. All the revisions that are configured to receive traffic have the  `ContainerHealthy` condition sets to `True`.
