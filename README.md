# これは何か

Azure Container InstancesをVNET内にデプロイしてみるサンプルです。

Webページにアクセスしたら動いているマシンのIPアドレスを表示するページを返します。

# 前提事項

- Terraform v1.1.2

# 環境構築

```shell
$ cd deploy/01_prepare
$ terraform init
$ terraform plan -var-file=../99_constant/terraform.tfvars
$ terraform apply -var-file=../99_constant/terraform.tfvars
```
