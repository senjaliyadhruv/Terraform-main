

module "db_instance" {
  source = "./modules"

  identifier           = var.identifier
  engine               = var.engine
  engine_version       = var.engine_version
  instance_class       = var.instance_class
  allocated_storage    = var.allocated_storage
  db_name              = var.db_name
  username             = var.username
  password             = var.password
  deletion_protection  = var.deletion_protection
  parameter_group_name = var.parameter_group_name
  db_subnet_group_name = var.db_subnet_group_name
  skip_final_snapshot  = var.skip_final_snapshot

}
