Alibaba Cloud E-MapReduce Terraform Module  
terraform-alicloud-emr-kafka
--------------------

English | [简体中文](https://github.com/terraform-alicloud-modules/terraform-alicloud-emr-kafka/blob/master/README-CN.md)

Terraform module which creates emr cluster instance(s) which cluster type is kafka on Alibaba Cloud. 

These types of resources are supported:

* [Alicloud_emr_cluster](https://www.terraform.io/docs/providers/alicloud/r/emr_cluster.html)


Usage
-----

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

## Examples

* [emr-kafka example](https://github.com/terraform-alicloud-modules/terraform-alicloud-emr-kafka/tree/master/example)

## Notes

From the version v1.1.0, the module has removed the following `provider` setting:

```hcl
provider "alicloud" {
  profile                 = var.profile != "" ? var.profile : null
  shared_credentials_file = var.shared_credentials_file != "" ? var.shared_credentials_file : null
  region                  = var.region != "" ? var.region : null
  skip_region_validation  = var.skip_region_validation
  configuration_source    = "terraform-alicloud-modules/emr-kafka"
}
```

If you still want to use the `provider` setting to apply this module, you can specify a supported version, like 1.0.0:

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

If you want to upgrade the module to 1.1.0 or higher in-place, you can define a provider which same region with
previous region:

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
or specify an alias provider with a defined region to the module using `providers`:

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

and then run `terraform init` and `terraform apply` to make the defined provider effect to the existing module state.

More details see [How to use provider in the module](https://www.terraform.io/docs/language/modules/develop/providers.html#passing-providers-explicitly)

Submit Issues
-------------
If you have any problems when using this module, please opening a [provider issue](https://github.com/terraform-providers/terraform-provider-alicloud/issues/new) and let us know.

**Note:** There does not recommend to open an issue on this repo.

Authors
-------
Created and maintained by Alibaba Cloud Terraform Team(terraform@alibabacloud.com)

License
----
Apache 2 Licensed. See LICENSE for full details.

Reference
---------
* [Terraform-Provider-Alicloud Github](https://github.com/terraform-providers/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://www.terraform.io/docs/providers/alicloud/index.html)