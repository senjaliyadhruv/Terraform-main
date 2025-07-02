resource "aws_db_instance" "default" {
  allocated_storage    = 10
  identifier           = "database-1"
  db_name              = "mydb"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  username             = "admin"
  password             = "Dhruv123"
  db_subnet_group_name = aws_db_subnet_group.sub-grp.id

  deletion_protection = false

  # Skip final snapshot on deletion
  skip_final_snapshot = true
}
resource "aws_db_subnet_group" "sub-grp" {
  name       = "my-db-subnet-group"
  provider   = aws.primary                                              # Use the primary provider for this resource
  subnet_ids = ["subnet-01820e7aa51574616", "subnet-0f380a7d09143313c"] # Replace with your actual subnet IDs
  tags = {
    Name = "My-DB-Subnet-Group"
  }
}
