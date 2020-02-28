output "this_emr_cluster_id" {
  description = "The unique id of this new created emr cluster."
  value       = module.emr-kafkaf.this_emr_cluster_id
}

output "this_emr_cluster_name" {
  description = "The name of this new created emr cluster."
  value       = module.emr-kafkaf.this_emr_cluster_name
}

output "this_emr_cluster_host_group" {
  description = "The emr cluster instance of host group which include ecs instance specification."
  value       = module.emr-kafkaf.this_emr_cluster_host_group
}

output "this_zone_id" {
  description = "The available zone id of this new created emr cluster."
  value       = module.emr-kafkaf.this_zone_id
}

output "this_role_id" {
  description = "The role id used to create this emr cluster instance."
  value       = module.emr-kafkaf.this_role_id
}

output "this_role_name" {
  description = "The role name to bound by this new created emr cluster."
  value       = module.emr-kafkaf.this_role_name
}