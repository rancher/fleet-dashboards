# fleet-dashboards

This is the home of the Fleet Grafana dashboards. From here, they are added to
the Fleet chart. The dashboards are generated using Jsonnet, a configuration
language for app and tool developers, and the Grafonnet library, which
simplifies the creation of Grafana dashboards. Jsonnet allows for modular and
reusable configurations, while Grafonnet provides a library to define Grafana
dashboards in Jsonnet. Read more about Jsonnet on
[jsonnet.org](https://jsonnet.org/) and about Grafonnet on
[grafana.github.io/grafonnet](https://grafana.github.io/grafonnet/index.html).

## Generating Dashboards

### Requirements

- Jsonnet (Go implementation)
- Grafonnet
- Go (for the installation of the dependencies using `go install`)

### Installing Jsonnet and Dependencies

If you have Go, you can install Jsonnet, jsonnet-linter, jsonnet-bundler and the
Grafonnet library using the following command:

```bash
make deps
```

This will use `go install` to install the dependencies in your `$GOPATH/bin/`
directory. Make sure that this directory is in your `PATH`.

It will also use jsonnet-bundler to install the Grafonnet library in the
`vendor/` directory of this repository.

If you feel uncomfortable using `go install`, you can install the dependencies
with the method that is comfortable for you.

### Generating the Dashboards

To generate the dashboards, run the command below. The dashboards will be
created in the directory `out/`.

```bash
make
```

## Setting up a development environment with Fleet and Rancher

First install all the requirements.

```bash
make deps
```

This command will install jsonnet, the jsonnet-linter and jsonnet-bundler using
`go install`. `jsonnet-bundler` is used to manage the dependencies of the
Jsonnet files. In our case, the only dependency is the Grafonnet library.

Once the dependencies are installed, you can run the following command to setup
a local development environment with Rancher and Fleet. Note that the scripts
mentioned here can be found in the
[rancher/fleet](https://github.com/rancher/fleet) repository, not in the
`fleet-dashboards` repository.

```sh
dev/setup-k3ds && dev/setup-k3ds-downstream && dev/setup-rancher-clusters
```

Make sure the installation of the `rancher` helm chart doesn't time out.
Subsequent commands might fail due to that.

If that was successful, you may want to upgrade fleet in Rancher to the local
dev version, especially if you require fleet to expose metrics that are not yet
in a released Fleet version but in your local repository. Otherwise you can
safely skip this step.

```sh
dev/build-fleet && dev/update-fleet-in-rancher-k3d dev
```

The last step is to install the `rancher-monitoring` chart in the local cluster
using the Rancher UI. You can find it in `Apps -> Charts` in the menu of the
local cluster. The card saying `Monitoring` is the `rancher-monitoring` chart
that needs to be installed. Afterwards use the Rancher UI to access Grafana and
Prometheus. The Rancher UI provides links to those services in the `Monitoring`
menu item.

### Debugging Dashboards

For quickly iterating between generating the dashboards and seeing the results
in the Grafana instance installed by the `rancher-monitoring` chart, the
`Makefile` of this repository contains a few quite useful targets.

- `build-dashboards`

  Iterates all jsonnet files in the `dashboards/` directory and generates the
  dashboards in the `out/` directory. This is the same as running `make` in the
  root of the repository.

- `build-configmap`

  Uses `kubectl` to create a configmap with the dashboards in the `out/`
  directory.

- `patch-configmap`

  Patches the generated configmap with the dashboards in the `out/` directory so
  that when the configmap is applied, Grafana is updated with the dashboards.

- `configmap-apply`

  Builds, patches and applies the configmap to the cluster.

- `debug`

  Runs `build-dashboards` followed by `configmap` to do all the steps from
  generating the dashboards and configmap over patching and applying to the
  cluster.

You can run any of these targets with `make <target>`.
