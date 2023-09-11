# Contributing

## Introduction

The [`container-app-operator`](https://github.com/dana-team/container-app-operator) and [`rcs-ocm-deployer`](https://github.com/dana-team/rcs-ocm-deployer) are applications using the Operator Pattern for running inside a container in a Kubernetes cluster.

## Makefile

The `Makefile` provides multiple targets for testing, building and running `Capp` and the `RCS` deployer.

## What to do before submitting a pull request

### Running unit tests

In order to verify your changes didn't break anything, you can run `make test`. It runs unit tests, but also various other pre-build tasks, in order to ensure that none of them is forgotten.

```bash
$ make test
```

### Running e2e tests

In order to run e2e tests against a real cluster, you need to make sure you have all prerequisites installed on the cluster. You can use the following `Makefile` target for `container-app-operator`:

```bash
$ make prereq
```

Run the following `Makefile` target for e2e-tests:

```bash
$ make test-e2e
```

## Building and Running Capp

Follow the `README.md` of the respective projects for information.

## Versioning and Branching

`Capp` and `RCS` follow [Semantic Versioning](https://semver.org). 

- an X (*major*) release indicates a set of backwards-compatible code. Changing X means there's a breaking change.

- a Y (*minor*) release indicates a minimum feature set. Changing Y means the addition of a backwards-compatible feature.

- a Z (*patch*) release indicates minimum set of bugfixes. Changing Z means a backwards-compatible change that doesn't add functionality.

*NB*: If the major release is `0`, any minor release may contain breaking changes.

### Branches

`Capp` and `RCS` contain two types of branches: the main branch and release-X branches.

The _main_ branch is where development happens. All the latest code, including breaking changes, happens on master.

The _release-X_ branches contain stable, backwards compatible code. Every major (X) release, a new such branch is created. It is from these branches that minor and patch releases are tagged.

### PR Process

1. Submit an issue describing your proposed change to the repo in question.

2. Fork the desired repo, develop and test your code changes.

3. Submit a pull request.

#### Commands and Workflow

`Capp` and `RCS` follow the standard Kubernetes workflow: any PR needs `lgtm` and `approved` labels. See the `OWNERS` file in each repo to see who has permission to approve PRs. PRs must also pass the tests before being merged.

See more [information here](https://github.com/kubernetes/community/blob/master/contributors/guide/pull-requests.md#the-testing-and-merge-workflow).

### Release Process

1. Generate release notes using the release note tooling.

2. Add a release for the project on GitHub, using those release notes, with a title of `vX.Y.Z`.

## Where the CI Tests are configured

See the action files (`.github/workflows`) on each repository to check its tests, and the scripts used on it.
