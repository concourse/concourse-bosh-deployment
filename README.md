# concourse-bosh-deployment

> A toolchain for deploying Concourse with [BOSH](https://bosh.io).

This repository is a community-maintained set of
[manifests](http://bosh.io/docs/manifest-v2.html) and [ops
files](http://bosh.io/docs/cli-ops-files.html) useful for deploying Concourse
in various configurations to various IaaSes.

**NOTE: This repository is effectively community-maintained, with only a
portion of these configurations tested in CI. Use at your own risk!**

## Requirements
- [Bosh CLI V2](https://bosh.io/docs/cli-v2.html#install)


## Usage

Clone this repo.

```shell
git clone https://github.com/concourse/concourse-bosh-deployment.git
cd concourse-bosh-deployment
```

Then, choose your adventure below.


## Deployment scenarios

### `lite/`: "Lite" directorless deployment

These manifests deploy Concourse, *without a BOSH director*, onto a single VM.

This approach is intended as an easy way to get a development Concourse
deployment up in the air and ready to `fly`!

Consult the [`lite` README](lite/README.md) for more information.

### `cluster/`: A full-blown BOSH deployment to a director

Consult the [`cluster` README](cluster/README.md) for more information.
