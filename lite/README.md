# Lite-VM Concourse deployment

A "lite" Concourse deployment will co-locate everything together, without a
BOSH director. The only real advantage of this is that it's a single VM, making
it easy to get your feet wet, but it won't help you scale later when you need
it.

Note that without a BOSH director, you really won't be able to use any BOSH
commands except `create-env` to create the VM and `delete-env` to delete it.
There is no `bosh ssh`, `bosh restart`, etc., and if something goes wrong, your
only real recourse is to just `delete-env` and try again.

To get started, pick your infrastructure under `infrastructures/`, and run
`create-env` with `-o path/to/infrastructure.yml`

For example, to create a VirtualBox VM running Concourse, run:

```shell
bosh create-env concourse.yml \
  -o ./infrastructures/virtualbox.yml \
  -l ../versions.yml \
  --vars-store vbox-creds.yml \
  --state vbox-state.json \
  -v internal_cidr=192.168.100.0/24 \
  -v internal_gw=192.168.100.1 \
  -v internal_ip=192.168.100.4 \
  -v public_ip=192.168.100.4
```

Note that you'll need [VirtualBox
5+](https://www.virtualbox.org/wiki/Downloads) for this scenario.

This should then result in a Concourse running and listening at
[http://192.168.100.4:8080](http://192.168.100.4:8080). You can then target it with `fly`:

```shell
fly -t vbox login -c http://192.168.100.4
```

Different infrastructures will require different parameters specified as `-v
name=value`. You can see which things you need to provide by just running the
command and seeing which values it blows up on.

For example, this will show what values the [GCP
infrastructure](infrastructures/gcp.yml) needs:

```shell
$ bosh create-env concourse.yml -l ../versions.yml -o infrastructures/gcp.yml
Deployment manifest: '/Users/pivotal/workspace/concourse-deployment/lite/concourse.yml'
Deployment state: '/Users/pivotal/workspace/concourse-deployment/lite/concourse-state.json'

Started validating
Failed validating (00:00:00)

Parsing release set manifest '/Users/pivotal/workspace/concourse-deployment/lite/concourse.yml':
  Evaluating manifest:
    - Expected to find variables:
        - gcp_credentials_json
        - internal_cidr
        - internal_gw
        - internal_ip
        - mbus_bootstrap_password
        - network
        - postgres_password
        - project_id
        - public_ip
        - subnetwork
        - tags
        - zone

Exit code 1
```

To learn what should be specified for those values, for now you'll have to just
have a look at the ops file. Hopefully there are comments.
