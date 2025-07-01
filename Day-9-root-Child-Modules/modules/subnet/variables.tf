variable "cidr_subnet" {
  description = "CIDR block for the subnet"
  type        = string
  default     = ""
  # default     = "172.31.150.0/28" #This is for when we want to execute subnet.
}
variable "az" {
  description = "Availability Zone for the subnet"
  type        = string
  default     = ""
  # default     = "us-east-1a"
}
variable "tags" {
  description = "Tags for the subnet"
  type        = map(string)
  default     = {}
  # default     = { Name = "Subnet" }
}
