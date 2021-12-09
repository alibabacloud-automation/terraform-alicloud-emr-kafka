# terraform-alicloud-emr-kafka


本 Module 主要基于阿里云[E-MapReduce](https://help.aliyun.com/document_detail/28068.html)来创建一个kafka集群。

本 Module 支持创建以下资源:

* [E-MapReduce集群实例](https://www.terraform.io/docs/providers/alicloud/r/emr_cluster.html)

## 用法


```hcl
provider "alicloud" {
  region  = "cn-hangzhou"
  profile = "Your-Profile-Name"
}

data "alicloud_emr_main_versions" "default" {
  cluster_type = ["KAFKA"]
}

data "alicloud_vpcs" "default" {
  is_default = true
}

data "alicloud_vswitches" "all" {
  vpc_id = data.alicloud_vpcs.default.ids.0
}

module "security_group" {
  source  = "alibaba/security-group/alicloud"
  vpc_id  = data.alicloud_vpcs.default.ids.0
  version = "~> 2.0"
}

module "emr-kafka" {
  source = "terraform-alicloud-modules/emr-kafka/alicloud"

  emr_version = data.alicloud_emr_main_versions.default.main_versions.0.emr_version
  charge_type = "PostPaid"

  vswitch_id        = data.alicloud_vswitches.all.ids.0
  security_group_id = module.security_group.this_security_group_id

  high_availability_enable = true
  is_open_public_ip        = true
  ssh_enable               = true
  master_pwd               = "YourPassword123!"
}
```

## 示例

* [E-MapReduce KAFKA集群示例](https://github.com/terraform-alicloud-modules/terraform-alicloud-emr-kafka/tree/master/example)

## 注意事项

本Module从版本v1.1.0开始已经移除掉如下的 provider 的显示设置：

```hcl
provider "alicloud" {
  profile                 = var.profile != "" ? var.profile : null
  shared_credentials_file = var.shared_credentials_file != "" ? var.shared_credentials_file : null
  region                  = var.region != "" ? var.region : null
  skip_region_validation  = var.skip_region_validation
  configuration_source    = "terraform-alicloud-modules/emr-kafka"
}
```

如果你依然想在Module中使用这个 provider 配置，你可以在调用Module的时候，指定一个特定的版本，比如 1.0.0:

```hcl
module "emr-kafka" {
  source  = "terraform-alicloud-modules/emr-kafka/alicloud"
  version     = "1.0.0"
  region      = "cn-hangzhou"
  profile     = "Your-Profile-Name"
  charge_type = "PostPaid"
  high_availability_enable = true
  // ...
}
```

如果你想对正在使用中的Module升级到 1.1.0 或者更高的版本，那么你可以在模板中显示定义一个系统过Region的provider：
```hcl
provider "alicloud" {
  region  = "cn-hangzhou"
  profile = "Your-Profile-Name"
}
module "emr-kafka" {
  source  = "terraform-alicloud-modules/emr-kafka/alicloud"
  charge_type = "PostPaid"
  high_availability_enable = true
  // ...
}
```
或者，如果你是多Region部署，你可以利用 `alias` 定义多个 provider，并在Module中显示指定这个provider：

```hcl
provider "alicloud" {
  region  = "cn-hangzhou"
  profile = "Your-Profile-Name"
  alias   = "hz"
}
module "emr-kafka" {
  source  = "terraform-alicloud-modules/emr-kafka/alicloud"
  providers = {
    alicloud = alicloud.hz
  }
  charge_type = "PostPaid"
  high_availability_enable = true
  // ...
}
```

定义完provider之后，运行命令 `terraform init` 和 `terraform apply` 来让这个provider生效即可。

更多provider的使用细节，请移步[How to use provider in the module](https://www.terraform.io/docs/language/modules/develop/providers.html#passing-providers-explicitly)

## Terraform 版本

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12.0 |
| <a name="requirement_alicloud"></a> [alicloud](#requirement\_alicloud) | >= 1.71.0 |

提交问题
-------
如果在使用该 Terraform Module 的过程中有任何问题，可以直接创建一个 [Provider Issue](https://github.com/terraform-providers/terraform-provider-alicloud/issues/new)，我们将根据问题描述提供解决方案。

**注意:** 不建议在该 Module 仓库中直接提交 Issue。

作者
-------
Created and maintained by Alibaba Cloud Terraform Team(terraform@alibabacloud.com)

许可
----
Apache 2 Licensed. See LICENSE for full details。

参考
---------
* [Terraform-Provider-Alicloud Github](https://github.com/terraform-providers/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://www.terraform.io/docs/providers/alicloud/index.html)