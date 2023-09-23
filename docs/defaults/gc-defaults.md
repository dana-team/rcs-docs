# GC Defaults

The following values are used for all `KSVC` CRs, which are created by `Capp` CRs. The values are also specified in the `config-gc` ConfigMap in the `knative-serving` namespace:

| Parameter                       | Value          | Description                                                                                   |
| ------------------------------- | --------------- | --------------------------------------------------------------------------------------------- |
| `retain-since-create-time`        | "48h"           | Duration since creation before considering a revision for garbage collection or "disabled."  |
| `retain-since-last-active-time`   | "15h"           | Duration since active before considering a revision for garbage collection or "disabled."   |
| `min-non-active-revisions`        | "20"            | Minimum number of non-active revisions to retain.                                             |
| `max-non-active-revisions`        | "1000"          | Maximum number of non-active revisions to retain or "disabled" to disable any maximum limit.  |
