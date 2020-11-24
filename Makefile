
default:
	echo "select one of the deploy or ssh commands to run"

deploy-651:
	bosh -e prod deploy -d conc-6-651 ./cluster/concourse.yml \
	  -l versions-651.yml \
	  --vars-store var-store-651.yml \
	  -o cluster/operations/basic-auth.yml \
	  --var local_user.username=admin \
	  --var local_user.password=admin \
	  --var external_url=http://localhost:8080 \
	  --var network_name=web \
	  --var web_vm_type=web \
	  --var db_vm_type=database \
	  --var db_persistent_disk_type=small \
	  --var worker_vm_type=worker \
	  --var deployment_name=conc-6-651 \
	  --var azs=[z1]

ssh-651:
	bosh -e prod -d conc-6-651 ssh web/0 --opts ' -L 8080:localhost:8080'

deploy-660:
	bosh -e prod deploy -d conc-6-660 ./cluster/concourse.yml \
	  -l versions-660.yml \
	  --vars-store var-store-660.yml \
	  -o cluster/operations/basic-auth.yml \
	  --var local_user.username=admin \
	  --var local_user.password=admin \
	  --var external_url=http://localhost:8080 \
	  --var network_name=web \
	  --var web_vm_type=web \
	  --var db_vm_type=database \
	  --var db_persistent_disk_type=small \
	  --var worker_vm_type=worker \
	  --var deployment_name=conc-6-660 \
	  --var azs=[z1]

ssh-660:
	bosh -e prod -d conc-6-660 ssh web/0 --opts ' -L 8080:localhost:8080'
