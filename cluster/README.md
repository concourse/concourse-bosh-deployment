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

For example, if you're going to deploy to a [BOSH
Lite](http://bosh.io/docs/bosh-lite.html) director, you would run:

```shell
bosh -e $BOSH_ENVIRONMENT update-cloud-config cloud_configs/vbox.yml

bosh -e $BOSH_ENVIRONMENT deploy -d concourse concourse.yml \
  -l ../versions.yml \
  --vars-store cluster-creds.yml \
  -o operations/static-web.yml \
  -o operations/no-auth.yml \
  --var web_ip=10.244.16.2 \
  --var external_url=http://10.244.16.2:8080 \
  --var network_name=concourse \
  --var web_vm_type=concourse \
  --var db_vm_type=concourse \
  --var db_persistent_disk_type=db \
  --var worker_vm_type=concourse
```

This should then result in a Concourse running and listening at
[http://10.244.15.2:8080](http://10.244.15.2:8080), ready for targeting
with `fly`:

```shell
fly -t ci login -c http://10.244.15.2:8080
```
