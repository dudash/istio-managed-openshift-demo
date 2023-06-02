# Setup on RHPDS

> Order the latest 4.x release [4.12 is here](https://demo.redhat.com/catalog?search=4.12&item=babylon-catalog-prod%2Fsandboxes-gpte.ocp412-wksp.prod)

> 1. Login via the CLI as `admin`

> 2. create a admin group `oc adm groups new cluster-admins admin` [*](1)

> 3. export a secret for AWS access and then create a secret for loki to use from those values

>> `oc extract secrets/aws-cloud-credentials -n openshift-machine-api `

>> `oc create secret generic logging-loki-s3 -n openshift-logging --from-file=access_key_id=aws_access_key_id --from-file=access_key_secret=aws_secret_access_key --from-literal=bucketnames=s3-bucket-loki-logs --from-literal=endpoint='https://s3.us-east-2.amazonaws.com' --from-literal=region='us-east-2'`

[1]: https://access.redhat.com/solutions/6975821
