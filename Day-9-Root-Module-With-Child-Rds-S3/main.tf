module "rds" {
  source               = "./RDS"
  identifier           = var.identifier
  engine               = var.engine
  engine_version       = var.engine_version
  instance_class       = var.instance_class
  allocated_storage    = var.allocated_storage
  db_name              = var.db_name
  username             = var.username
  password             = var.password
  db_subnet_group_name = var.db_subnet_group_name
  parameter_group_name = var.parameter_group_name
  deletion_protection  = var.deletion_protection
  skip_final_snapshot  = var.skip_final_snapshot

}

