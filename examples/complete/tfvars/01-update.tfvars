#alicloud_ram_role
document             = <<EOF
    {
        "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Effect": "Allow",
            "Principal": {
            "Service": [
                "ecs.aliyuncs.com"
            ]
            }
        }
        ],
        "Version": "1"
    }
    EOF
ram_role_description = "update_ram_role_description"
force                = true

#alicloud_emr_cluster
emr_cluster_name = "update_emr_cluster_name"
host_groups = [
  {
    host_group_name = "master_group"
    host_group_type = "MASTER"
    node_count      = "3"
    disk_count      = "2"
  },
  {
    host_group_name = "core_group"
    host_group_type = "CORE"
    node_count      = "2"
    disk_count      = "3"
  },
  {
    host_group_name = "task_group"
    host_group_type = "TASK"
    node_count      = "2"
    disk_count      = "3"
  }
]
disk_capacity        = 120
system_disk_capacity = 120