# concourse-deployment
> A lightweight, single-vm Concourse deployment using `bosh create-env` ([see BOSH cli docs](https://bosh.io/docs/cli-v2.html))

![](https://upload.wikimedia.org/wikipedia/commons/thumb/c/c4/Paper_Airplane.png/200px-Paper_Airplane.png)

This approach is intended as an easy way to get a development Concourse deployment up in the air and ready to `fly`!

This method can be used to create a single-vm Concourse deployment; similar to the `vagrant up` experience, but without the additional effort to build Vagrant boxes of each Concourse release on bosh.io.

 A number of deployment scenarios ( more coming soon ) are supported by applying [BOSH operations files](https://bosh.io/docs/cli-ops-files.html) to the base `concourse.yml` using `bosh create-env`:

- VirtualBox
- Google Cloud Platform
- VMware vSphere
- Amazon Web Services (AWS)

## Requirements
- [Bosh CLI V2](https://bosh.io/docs/cli-v2.html#install)


## Usage

Clone this repo.

```shell
git clone https://github.com/concourse/concourse-deployment.git
cd concourse-deployment
```

## Create the Concourse VM in VirtualBox
**Additional Requirements**
- (VirtualBox 5+)[https://www.virtualbox.org/wiki/Downloads]

```shell
bosh create-env concourse.yml \
  -o ./infrastructures/virtualbox.yml \
  --vars-store vbox-creds.yml \
  --state vbox-state.json \
  -v internal_cidr=192.168.50.0/24 \
  -v internal_gw=192.168.50.1 \
  -v internal_ip=192.168.50.4 \
  -v public_ip=192.168.50.4
```

## Create the Concourse VM in Google Cloud Platform

```shell
#!/bin/bash

gcp_credentials_json=$(cat gcp.json)

bosh create-env concourse.yml \
  -o infrastructures/gcp.yml \
  --vars-store gcp-creds.yml \
  --state gcp-state.json \
  -v gcp_credentials_json="'$gcp_credentials_json'" \
  -v internal_cidr= \
  -v internal_gw= \
  -v internal_ip= \
  -v public_ip= \
  -v network= \
  -v project_id= \
  -v subnetwork= \
  -v tags=\
  -v zone=
```

## Create the Concourse VM in VMware vSphere

```shell
bosh create-env concourse.yml \
  -o infrastructures/vsphere.yml \
  --vars-store vsphere-creds-temp.yml \
  --state vsphere-state-temp.json \
  -v vcenter_ip= \
  -v vcenter_user= \
  -v vcenter_password= \
  -v vcenter_dc= \
  -v vcenter_vms= \
  -v vcenter_templates= \
  -v vcenter_ds= \
  -v vcenter_disks= \
  -v vcenter_cluster= \
  -v vcenter_resource_pool= \
  -v network_name= \
  -v internal_cidr= \
  -v internal_gw= \
  -v internal_ip= \
  -v public_ip=
 ```

 ## Create the Concourse VM in AWS

 ```shell
 bosh create-env concourse.yml \
   -o ./infrastructures/aws.yml \
   --vars-store aws-creds.yml \
   --state aws-state.json \
   -v access_key_id=... \
   -v secret_access_key=... \
   -v region=us-east-1 \
   -v az=us-east-1b \
   -v default_key_name=bosh \
   -v default_security_groups=[bosh] \
   -v subnet_id=subnet-... \
   -v director_name=bosh-1 \
   -v internal_cidr=192.168.50.0/24 \
   -v internal_gw=192.168.50.1 \
   -v internal_ip=192.168.50.4 \
   -v public_ip=192.168.50.4
   --var-file private_key=~/Downloads/bosh.pem
 ```

 ## Accessing your Concourse

 The web server will be running at public-ip you specifid. Download the Fly CLI for your system, and target the deployed Concourse.

`fly -t lite login -c http://public-ip:8080`
