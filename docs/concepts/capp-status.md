# How to know if Capp is currently healthy or non-healthy? 

The `Capp` status Composed of a few parts, in this doc we will look into two of them `Revisions` and `knativeObjectStatus`.

Capp `knativeObject` status example:
```
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

`latestReadyRevisionName`: holds the name of the latest Revision stamped out from this Configuration that has had its “Ready” condition become “True”.



`traffic`: Traffic holds the configured traffic distribution. These entries will always contain RevisionName references. 
#### Conditions

`Ready`: All the revisions is starting to materialize runtime resources, and becomes true when those resources are ready.


`RoutesReady`: Sets when underlying routes for all components have reported readiness.


`ConfigurationsReady`: Sets when the service's underlying configurations have reported readiness.

Capp `Revisions` status example:

```
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

### explanation

`ActualReplicas`:  reflects the amount of ready pods running this revision.

`DesiredReplicas`: reflects the desired amount of pods running this revision.`

#### Conditions

`Ready`: Sets when the revision is starting to materialize runtime resources, and becomes true when those resources are ready.

`ResourceAvailable`:  Sets when underlying Kubernetes resources have been provisioned.

`Active`: Sets when the revision is receiving traffic.

`ContainerHealthy`: Sets when the revision readiness check completes.


## Conclusion

We can consider `Capp` healthy if it has the `Ready` condition inside the `knativeObjectStatus` sets to `True`, and if all the revisions that are configured to recive trafic have the  `ContainerHealthy` condition sets to `True`.