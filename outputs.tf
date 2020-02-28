output "this_emr_cluster_id" {
  description = "The unique id of this new created emr cluster."
  value       = concat(alicloud_emr_cluster.this.*.id, [""])[0]
}

output "this_emr_cluster_name" {
  description = "The name of this new created emr cluster."
  value       = concat(alicloud_emr_cluster.this.*.name, [""])[0]
}

output "this_emr_cluster_host_group" {
  description = "The emr cluster instance of host group which include ecs instance specification."
  value       = concat(alicloud_emr_cluster.this.*.host_group, [""])[0]
}

output "this_zone_id" {
  description = "The available zone id of this new created emr cluster."
  value       = concat(alicloud_emr_cluster.this.*.zone_id, [""])[0]
}

output "this_vswitch_id" {
  description = "The vswitch id of this new created emr cluster."
  value       = concat(alicloud_emr_cluster.this.*.zone_id, [""])[0]
}

output "this_security_group_id" {
  description = "The security group id of this new created emr cluster."
  value       = concat(alicloud_emr_cluster.this.*.security_group_id, [""])[0]
}

output "this_role_id" {
  description = "The role id used to create this emr cluster instance."
  value       = concat(alicloud_ram_role.default.*.id, [""])[0]
}

output "this_role_name" {
  description = "The role name to bound by this new created emr cluster."
  value       = concat(alicloud_ram_role.default.*.name, [""])[0]
}