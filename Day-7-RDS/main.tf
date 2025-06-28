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
  parameter_group_name = "default.mysql8.0"
  provider             = aws.primary # Use the primary provider for this resource

  #enable backups and retention
  backup_retention_period = 7
  backup_window           = "02:00-03:00" #Daily backup window(UTC time)

  #enable monitoring(CloudWatch Enhanced Monitoring)
  monitoring_interval = 60 #Collect metrics every 60 seconds
  monitoring_role_arn = aws_iam_role.rds_monitoring.arn

  #Enable performance insights
  # performance_insights_enabled          = true
  # performance_insights_retention_period = 7 # Retain insights for 7 days

  #maintenance window
  maintenance_window = "sun:04:00-sun:05:00" # Maintenance every Sunday from 04:00 to 05:00 (UTC)

  # Enable deletion protection (to prevent accidental deletion)
  deletion_protection = false

  # Skip final snapshot on deletion
  skip_final_snapshot = true

  # depends_on = [ aws_db_subnet_group.sub-grp ]
}
# IAM Role for RDS monitoring
resource "aws_iam_role" "rds_monitoring" {
  name     = "rds-monitoring-role1"
  provider = aws.primary # Use the primary provider for this resource
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow"
      Principal = {
        Service = "monitoring.rds.amazonaws.com"
      }
    }]
  })
}
# Attach the AWS managed policy for RDS monitoring
resource "aws_iam_role_policy_attachment" "rds_monitoring_attach" {
  provider   = aws.primary # Use the primary provider for this resource
  role       = aws_iam_role.rds_monitoring.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}
resource "aws_db_subnet_group" "sub-grp" {
  name       = "my-db-subnet-group"
  provider   = aws.primary                                              # Use the primary provider for this resource
  subnet_ids = ["subnet-01820e7aa51574616", "subnet-0f380a7d09143313c"] # Replace with your actual subnet IDs
  tags = {
    Name = "My-DB-Subnet-Group"
  }
}


resource "aws_db_instance" "read_replica" {
  identifier          = "my-read-replica"
  instance_class      = "db.t3.micro"
  replicate_source_db = aws_db_instance.default.arn
  publicly_accessible = true

  # Network configuration in secondary region
  db_subnet_group_name = aws_db_subnet_group.replica_subnet.id

  # Optional but recommended for replicas
  skip_final_snapshot = true

  depends_on = [aws_db_instance.default]
}

resource "aws_db_subnet_group" "replica_subnet" {
  name       = "my-db-subnet-group-replica"
  subnet_ids = ["subnet-0f99999f00da48f79", "subnet-08f57986feafde557"] # Replace with your actual subnet IDs
  tags = {
    Name = "My-Replica-DB-Subnet-Group"
  }
}
