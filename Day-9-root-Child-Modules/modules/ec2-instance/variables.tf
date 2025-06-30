variable "ami" {
  description = "The AMI ID to use for the instance"
  type        = string
  default     = ""
}
variable "instance_type" {
  description = "The type of instance to create"
  type        = string
  default     = ""
}
variable "instance_name" {
  description = "The name of the instance"
  type        = string
  default     = ""
}
