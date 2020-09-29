# Wireguard Server on IBM Cloud VPC

## Install Wireguard Tools


## Generate Wireguard Client Keys
```
wg genkey | tee privatekey | wg pubkey | tee publickey
```

## Update Credentials File 

Copy example file 
```shell
cp credentials-example credentials.tfvars
```

### Update `credentials.tfvars` file

```shell
remote_ssh_ip      = "Your Local IP"
client_private_key = "Client Private Key"
client_public_key  = "Client Public Key"
resource_group     = "Resource Group"
```

## Initialize Terraform
```shell
$ terraform init
```

## Run Terraform Plan

```shell
$ terraform plan -var-file="./credentials.tfvars" -out "default.tfplan"
```