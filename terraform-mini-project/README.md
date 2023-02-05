## Steps for spinning up this infrastructure
---

### Prerequisites

1. Have aws cli installed
2. setup your aws profile by either:

   - running `aws configure` and providing the necessary details
   - import from a csv file by running `aws configure import --csv file://<path to file>`(recommended)


Before performing the following steps, makeu sure you copy the file `terraform.tfvars.copy` and rename `terraform.tfvars` edit this file accordingly. Do the same with the `ansible/ansible.cfg.copy` file.
### Create remote backend for terraform
- cd into `backend`
- run `terraform init`
- run `terraform validate` to check script correctness
- run `terraform plan` to plan out your resources
- run terraform apply` to create resources

### To actually create the infrastructure using terraform
- cd back out
- run `terraform init` to initialize remote backend
- run `terraform apply` to create resources

### To setup infrastructure management for the created infrastructure using ansible
- cd into the ansible directory
- run `ansible-playbook main.yml`


**Fin**

> P.S: Seems variables cannot be used in the backend, so you'd have to put > the values there after setting the s3 and dynamo db table name variables.
