data "alicloud_emr_instance_types" "default" {
  destination_resource  = "InstanceType"
  cluster_type          = "KAFKA"
  support_local_storage = false
  instance_charge_type  = "PostPaid"
  support_node_type     = ["MASTER", "CORE", "TASK", "GATEWAY"]
}

data "alicloud_emr_disk_types" "data_disk" {
  destination_resource = "DataDisk"
  cluster_type         = "KAFKA"
  instance_charge_type = "PostPaid"
  instance_type        = data.alicloud_emr_instance_types.default.types.0.id
  zone_id              = data.alicloud_emr_instance_types.default.types.0.zone_id
}

data "alicloud_emr_disk_types" "system_disk" {
  destination_resource = "SystemDisk"
  cluster_type         = "KAFKA"
  instance_charge_type = "PostPaid"
  instance_type        = data.alicloud_emr_instance_types.default.types.0.id
  zone_id              = data.alicloud_emr_instance_types.default.types.0.zone_id
}

data "alicloud_emr_main_versions" "default" {
  cluster_type = ["KAFKA"]
}

module "vpc" {
  source             = "alibaba/vpc/alicloud"
  create             = true
  vpc_cidr           = "172.16.0.0/16"
  vswitch_cidrs      = ["172.16.0.0/21"]
  availability_zones = [data.alicloud_emr_instance_types.default.types.0.zone_id]
}

module "security_group" {
  source = "alibaba/security-group/alicloud"
  vpc_id = module.vpc.this_vpc_id
}

module "emr-kafkaf" {
  source = "../.."

  #alicloud_ram_role
  create               = true
  ram_role_name        = "tf-ram-role-name"
  document             = var.document
  ram_role_description = var.ram_role_description
  force                = var.force

  #alicloud_emr_cluster
  emr_cluster_name         = var.emr_cluster_name
  emr_version              = data.alicloud_emr_main_versions.default.main_versions.0.emr_version
  zone_id                  = data.alicloud_emr_instance_types.default.types.0.zone_id
  security_group_id        = module.security_group.this_security_group_id
  vswitch_id               = module.vpc.this_vswitch_ids[0]
  high_availability_enable = true
  ssh_enable               = true
  master_pwd               = "YourPassword123!"
  charge_type              = "PostPaid"
  is_open_public_ip        = true
  host_groups              = var.host_groups
  instance_type            = data.alicloud_emr_instance_types.default.types.0.id
  disk_type                = data.alicloud_emr_disk_types.data_disk.types.0.value
  disk_capacity            = var.disk_capacity
  system_disk_type         = data.alicloud_emr_disk_types.system_disk.types.0.value
  system_disk_capacity     = var.system_disk_capacity

}