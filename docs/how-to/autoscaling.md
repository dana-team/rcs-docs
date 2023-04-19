# Autoscaling
`RCS`, through the underlying `Knative`, supports `Knative Pod Autoscaler` (`KPA`) and Kubernetes' `Horizontal Pod Autoscaler` (`HPA`). Whether the `Capp`, through the underlying `ksvc` uses `HPA` or `KPA` depends on the `scale-metric` used in the `Capp` CR.

