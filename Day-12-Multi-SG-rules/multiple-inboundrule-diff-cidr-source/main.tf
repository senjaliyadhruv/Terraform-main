resource "aws_security_group" "devops_project_veera" {
  name        = "devops-project-veera"
  description = "Allow restricted inbound traffic"

  ingress = [
    {
      description = "SSH access from office network"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["203.0.113.0/24"] # Replace with your IP
    },
    {
      description = "HTTP access for public users"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"] # Public access
    },
    {
      description = "HTTPS access for public users"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"] # Public access
    },
    {
      description = "App access from internal VPC"
      from_port   = 8080
      to_port     = 8080
      protocol    = "tcp"
      cidr_blocks = ["10.0.0.0/16"] # Replace with your VPC CIDR
    },
    {
      description = "SonarQube or Jenkins access (Restrict to VPN or internal network)"
      from_port   = 9000
      to_port     = 9000
      protocol    = "tcp"
      cidr_blocks = ["192.168.1.0/24"] # Replace with your VPN subnet
    }
  ]

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "devops-project-veera"
  }
}
