# Paper Plane
> A lightweight, single-vm Concourse deployment using `bosh create-env` ([see BOSH cli docs](https://bosh.io/docs/cli-v2.html))

![](https://upload.wikimedia.org/wikipedia/commons/thumb/c/c4/Paper_Airplane.png/200px-Paper_Airplane.png)

This approach is intended as an easy way to get a development Concourse deployment up in the air and ready to `fly`! A number of deployment scenarios ( more coming soon ) are supported by applying [BOSH operations files](https://bosh.io/docs/cli-ops-files.html) to the base `concourse-paper-plane.yml` using `bosh create-env`:

- [VirtualBox for Local Development](#local-development)
- Google Cloud Platform

## Requirements
- [Bosh CLI V2](https://bosh.io/docs/cli-v2.html#install)


# Local Development

This method can be used to create a local, single-vm Concourse deployment for development; similar to the `vagrant up` experience, but without the additional effort to build Vagrant boxes of each Concourse release on bosh.io.

## Additional Requirements
- (VirtualBox 5+)[https://www.virtualbox.org/wiki/Downloads]

## Usage

Clone this repo.

```shell
git clone git@github.com:concourse/paper-plane.git
cd paper-plane
```

Create the Concourse VM in VirtualBox

```shell
bosh create-env concourse-paper-plane.yml \
  -o ./infrastructures/virtualbox.yml \
  --vars-store vbox-creds.yml \
  --state vbox-state.json \
  -v internal_cidr=192.168.50.0/24 \
  -v internal_gw=192.168.50.1 \
  -v internal_ip=192.168.50.4 \
  -v public_ip=192.168.50.4
```

The web server will be running at `192.168.50.4:8080`. Download the Fly CLI for your system, and target the deployed Concourse.

`fly -t lite login -c http://192.168.50.4:8080`
