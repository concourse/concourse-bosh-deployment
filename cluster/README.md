# Cluster Concourse deployment

A clustered Concourse deployment exercises the full might of BOSH. It
provides disaster recovery for your VMs, safe management of your
persistent state (including resizing of the available space,
snapshot/restore, etc.), and in general will make your life easier once
you get it going.

You'll first need to set up the [Cloud
Config](http://bosh.io/docs/cloud-config.html) on your director. This part
depends on your infrastructure of choice. There are a few example configs under
[cloud_configs/](cloud_configs/).

Here's an example command for deploying Concourse to a BOSH director. Most of the
values for the fields can be found in your cloud config, which you can retrieve using
the `cloud-config` command.

```shell
bosh -e $BOSH_ENVIRONMENT update-cloud-config cloud_configs/vbox.yml

bosh -e $BOSH_ENVIRONMENT deploy -d concourse concourse.yml \
  -l ../versions.yml \
  --vars-store cluster-creds.yml \
  -o operations/static-web.yml \
  -o operations/basic-auth.yml \
  --var local_user.username=admin \
  --var local_user.password=admin \
  --var web_ip=10.244.15.2 \
  --var external_url=http://10.244.15.2:8080 \
  --var network_name=concourse \
  --var web_vm_type=concourse \
  --var db_vm_type=concourse \
  --var db_persistent_disk_type=db \
  --var worker_vm_type=concourse \
  --var deployment_name=concourse \
  --var azs=[z1]
```

This should then result in a Concourse running and listening at
[http://10.244.15.2:8080](http://10.244.15.2:8080), ready for targeting
with `fly`:

```shell
fly -t ci login -c http://10.244.15.2:8080 -u admin -p admin
```

To access the web dashboard locally, setup port forwarding using the following:

```shell
bosh -e $BOSH_ENVIRONMENT -d $DEPLOYMENT_NAME ssh web/0 --opts ' -L 8080:localhost:8080'
```

## Using BOSH BootLoader

The `bbl` project maintains documentation for deploying Concourse quickly and
easily across a few supported IaaSes. Consult their
[`concourse.md`](https://github.com/cloudfoundry/bosh-bootloader/blob/master/docs/concourse.md)
docs for more information.


## External Concourse worker

In case you have a distributed setup with external concourse workers deployed on another BOSH
you can deploy those with:
```shell
bosh -e $BOSH_ENVIRONMENT deploy -d concourse-worker external-worker.yml \
  -l ../versions.yml \
  -v external_worker_network_name=concourse \
  -v worker_vm_type=concourse-workers \
  -v instances=2 \
  -v azs=[z1] \
  -v deployment_name=concourse-worker \
  -v tsa_host=10.244.15.2 \
  -v worker_tags=[tags] \
  -l <path/to/secrets.yml>
```

The `secrets.yml` file has to contain the public tsa host key of the concourse master and the worker private
key:

```yaml
tsa_host_key:
  public_key: <public_key>

worker_key:
  private_key: |
    -----BEGIN RSA PRIVATE KEY-----
    ...
    -----END RSA PRIVATE KEY-----
```
