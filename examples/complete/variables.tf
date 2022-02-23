#alicloud_ram_role
variable "document" {
  description = "Authorization strategy of the RAM role."
  type        = string
  default     = <<EOF
    {
        "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Effect": "Allow",
            "Principal": {
            "Service": [
                "emr.aliyuncs.com",
                "ecs.aliyuncs.com"
            ]
            }
        }
        ],
        "Version": "1"
    }
    EOF
}

variable "ram_role_description" {
  description = "The specification of module ram role description."
  type        = string
  default     = "ram_role_description"
}

variable "force" {
  description = "This parameter is used for resource destroy"
  type        = bool
  default     = false
}

#alicloud_emr_cluster
variable "emr_cluster_name" {
  description = "The name of this new created emr cluster instance."
  type        = string
  default     = "emr_cluster_name"
}


variable "host_groups" {
  description = "Host groups to attach to the emr cluster instance."
  type        = list(map(string))
  default = [
    {
      host_group_name = "master_group"
      host_group_type = "MASTER"
      node_count      = "2"
      disk_count      = "1"
    },
    {
      host_group_name = "core_group"
      host_group_type = "CORE"
      node_count      = "3"
      disk_count      = "4"
    },
    {
      host_group_name = "task_group"
      host_group_type = "TASK"
      node_count      = "1"
      disk_count      = "4"
    }
  ]
}

variable "disk_capacity" {
  description = "The host group of ecs mount disk capacity to create emr cluster instance."
  type        = number
  default     = 160
}

variable "system_disk_capacity" {
  description = "The host group of ecs mount system disk capacity to create emr cluster instance."
  type        = number
  default     = 160
}