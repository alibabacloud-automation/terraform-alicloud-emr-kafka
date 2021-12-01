variable "profile" {
  default = "default"
}

variable "region" {
  default = "cn-hangzhou"
}

provider "alicloud" {
  region  = var.region
  profile = var.profile
}

data "alicloud_emr_main_versions" "default" {
  cluster_type = ["KAFKA"]
}

data "alicloud_vpcs" "default" {
  is_default = true
}

resource "alicloud_vpc" "default" {
  count = length(data.alicloud_vpcs.default.ids) > 0 ? 0 : 1
  cidr_block = "172.16.0.0/12"
  vpc_name = "test_vpc_007"
}

data "alicloud_vswitches" "default" {
  vpc_id = data.alicloud_vpcs.default.ids.0
  zone_id = data.alicloud_emr_instance_types.default.types.0.zone_id
}

resource "alicloud_vswitch" "default" {
  count = length(data.alicloud_vswitches.default.ids) > 0 ? 0 : 1
  vswitch_name              = "redis_vpc_007"
  zone_id                   = data.alicloud_emr_instance_types.default.types.0.zone_id
  vpc_id                    = length(data.alicloud_vpcs.default.ids) > 0 ?  data.alicloud_vpcs.default.vpcs.0.id : alicloud_vpc.default.0.id
  cidr_block                = "172.16.0.0/24"
}

data "alicloud_emr_instance_types" "default" {
  destination_resource  = "InstanceType"
  cluster_type          = "KAFKA"
  support_local_storage = false
  instance_charge_type  = "PostPaid"
  support_node_type     = ["MASTER", "CORE", "TASK", "GATEWAY"]
}

module "security_group" {
  region  = var.region
  profile = var.profile
  source  = "alibaba/security-group/alicloud"
  vpc_id  = length(data.alicloud_vpcs.default.ids) > 0 ?  data.alicloud_vpcs.default.vpcs.0.id : alicloud_vpc.default.0.id
  version = "~> 2.0"
}

module "emr-kafkaf" {
  source = "../.."

  create = true

  emr_version = data.alicloud_emr_main_versions.default.main_versions.0.emr_version
  charge_type = "PostPaid"

  vswitch_id        = length(data.alicloud_vswitches.default.ids) > 0 ? data.alicloud_vswitches.default.ids.0 : alicloud_vswitch.default.0.id
  security_group_id = module.security_group.this_security_group_id

  high_availability_enable = true
  is_open_public_ip        = true
  ssh_enable               = true
  master_pwd               = "YourPassword123!"
  instance_type = data.alicloud_emr_instance_types.default.types.0.id
  zone_id = data.alicloud_emr_instance_types.default.types.0.zone_id
}