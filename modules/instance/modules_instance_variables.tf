variable "instance_family_image" {
  description = "Instance image"
  type        = string
  default     = "container-optimized-image"
}

variable "vpc_subnet_id" {
  description = "VPC subnet network id"
  type        = string
}

variable "managers" {
  description = "Count of manager nodes"
  type        = number
  default     = 1
}

variable "workers" {
  description = "Count of worker nodes"
  type        = number
  default     = 2
}

variable "ssh_credentials" {
  description = "Credentials for connect to instances"
  type        = object({
    user        = string
    private_key = string
    pub_key     = string
  })
  default     = {
    user        = "user"
    private_key = "path/to/key"
    pub_key     = "path/to/key"
  }
}