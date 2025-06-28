resource "aws_db_instance" "name" {
  allocated_storage    = 10
  db_name              = "mydb"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t2.micro"
  username             = "admin"
  password             = "Dhruv123"
  db_subnet_group_name = aws_db_subnet_group.sub-grp.id
  parameter_group_name = "default.mysql8.0"

  #enable backups and retention
  backup_retention_period = 7
  backup_window           = "02:00-03:00" #Daily backup window(UTC time)

  #enable monitoring(CloudWatch Enhanced Monitoring)
  monitoring_interval = 60 #Collect metrics every 60 seconds
  monitoring_role_arn = aws_iam_role.rds_monitoring.arn

  #Enable performance insights
  performance_insights_enabled          = true
  performance_insights_retention_period = 7 # Retain insights for 7 days

  #maintenance window
  maintenance_window = "sun:04:00-sun:05:00" # Maintenance every Sunday from 04:00 to 05:00 (UTC)

  # Enable deletion protection (to prevent accidental deletion)
  deletion_protection = true

  # Skip final snapshot on deletion
  skip_final_snapshot = true

  # depends_on = [ aws_db_subnet_group.sub-grp ]
}
# IAM Role for RDS monitoring
resource "aws_iam_role" "rds_monitoring" {
  name = "rds-monitoring-role"
  assume_role_policy = jsondecode({
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
  role       = aws_iam_role.rds_monitoring.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}
resource "aws_db_subnet_group" "sub-grp" {
  name       = "my-db-subnet-group"
  subnet_ids = ["subnet-01820e7aa51574616", "subnet-0f380a7d09143313c"] # Replace with your actual subnet IDs
  tags = {
    Name = "My-DB-Subnet-Group"
  }
}
