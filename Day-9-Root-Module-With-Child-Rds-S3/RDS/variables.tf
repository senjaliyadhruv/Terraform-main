variable "allocated_storage" {
  description = "The amount of storage (in gigabytes) to allocate for the database instance."
  type        = number
  default     = 10
}
variable "identifier" {
  description = "The identifier for the database instance."
  type        = string
  default     = "database-1"
}
variable "db_name" {
  description = "The name of the database to create when the DB instance is created."
  type        = string
  default     = "mydb"
}
variable "engine" {
  description = "The database engine to use."
  type        = string
  default     = "mysql"
}
variable "engine_version" {
  description = "The version of the database engine to use."
  type        = string
  default     = "8.0"
}
variable "instance_class" {
  description = "The instance class for the database instance."
  type        = string
  default     = "db.t3.micro"
}
variable "username" {
  description = "The username for the database instance."
  type        = string
  default     = "admin"
}
variable "password" {
  description = "The password for the database instance."
  type        = string
  default     = "Dhruv123"
}
variable "db_subnet_group_name" {
  description = "The name of the DB subnet group to associate with the database instance."
  type        = string
  default     = "my-db-subnet-group"
}
variable "parameter_group_name" {
  description = "The name of the DB parameter group to associate with the database instance."
  type        = string
  default     = "default.mysql8.0"
}


variable "deletion_protection" {
  description = "Whether to enable deletion protection for the database instance."
  type        = bool
  default     = false
}
variable "skip_final_snapshot" {
  description = "Whether to skip the final snapshot when the database instance is deleted."
  type        = bool
  default     = true
}


