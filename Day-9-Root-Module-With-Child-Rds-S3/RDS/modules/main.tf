resource "aws_db_instance" "default" {
  allocated_storage    = var.allocated_storage
  identifier           = var.identifier
  db_name              = var.db_name
  engine               = var.engine
  engine_version       = var.engine_version
  instance_class       = var.instance_class
  username             = var.username
  password             = var.password
  db_subnet_group_name = aws_db_subnet_group.sub-grp.id
  parameter_group_name = "default.mysql8.0"

  # Enable deletion protection (to prevent accidental deletion)
  deletion_protection = var.deletion_protection

  # Skip final snapshot on deletion
  skip_final_snapshot = var.skip_final_snapshot

}


resource "aws_db_subnet_group" "sub-grp" {
  name       = var.db_subnet_group_name
  subnet_ids = ["subnet-01820e7aa51574616", "subnet-0f380a7d09143313c"] # Replace with your actual subnet IDs
  tags = {
    Name = var.db_subnet_group_name
  }
}
