variable "create" {
  description = "The switch to control creation of the emr cluster or not."
  type        = bool
  default     = false
}

variable "region" {
  description = "(Deprecated from version 1.1.0) The region used to launch this module resources."
  type        = string
  default     = ""
}

variable "profile" {
  description = "(Deprecated from version 1.1.0) The profile name as set in the shared credentials file. If not set, it will be sourced from the ALICLOUD_PROFILE environment variable."
  type        = string
  default     = ""
}

variable "shared_credentials_file" {
  description = "(Deprecated from version 1.1.0) This is the path to the shared credentials file. If this is not set and a profile is specified, $HOME/.aliyun/config.json will be used."
  type        = string
  default     = ""
}

variable "skip_region_validation" {
  description = "(Deprecated from version 1.1.0) Skip static validation of region ID. Used by users of alternative AlibabaCloud-like APIs or users w/ access to regions that are not public (yet)."
  type        = bool
  default     = false
}

variable "emr_cluster_name" {
  description = "The name of this new created emr cluster instance."
  type        = string
  default     = "terraform-test-kafka-module"
}

variable "ram_role_name" {
  description = "The role name to bound by this new created emr cluster."
  type        = string
  default     = ""
}

variable "support_local_storage" {
  description = "Whether to support local storage."
  type        = bool
  default     = false
}
variable "zone_id" {
  description = "The zone id used to created emr cluster."
  type        = string
  default     = ""
}

variable "vswitch_id" {
  description = "The vswitch id used to created emr cluster."
  type        = string
  default     = ""
}

variable "security_group_id" {
  description = "The security group id used to created emr cluster."
  type        = string
  default     = ""
}

variable "charge_type" {
  description = "The instance charge type. Valid values: Prepaid and PostPaid. Default to PostPaid."
  type        = string
  default     = "PostPaid"
}

variable "high_availability_enable" {
  description = "The high availability of this emr cluster is enable or not."
  type        = bool
  default     = true
}

variable "is_open_public_ip" {
  description = "The emr cluster ecs instance is open public ip or not."
  type        = bool
  default     = true
}

variable "ssh_enable" {
  description = "The emr cluster ecs instance is ssh enable or not."
  type        = bool
  default     = true
}

variable "master_pwd" {
  description = "The master password of this new created emr cluster."
  type        = string
  default     = "YourPassword123!"
}

variable "instance_type" {
  description = "The host group of ecs instance type to create emr cluster instance."
  type        = string
  default     = ""
}

variable "disk_type" {
  description = "The host group of ecs mount disk type to create emr cluster instance. Supported value: cloud, cloud_efficiency, cloud_ssd, local_disk, cloud_essd."
  type        = string
  default     = ""
}

variable "disk_capacity" {
  description = "The host group of ecs mount disk capacity to create emr cluster instance."
  type        = number
  default     = 0
}

variable "system_disk_type" {
  description = "The host group of ecs mount system disk type to create emr cluster instance. Supported value: cloud, cloud_efficiency, cloud_ssd, local_disk, cloud_essd."
  type        = string
  default     = ""
}

variable "system_disk_capacity" {
  description = "The host group of ecs mount system disk capacity to create emr cluster instance."
  type        = number
  default     = 0
}

variable "emr_version" {
  description = "The version of this new created emr kafka cluster."
  type        = string
  default     = "EMR-3.24.0"
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

