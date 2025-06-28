# VPC
resource "aws_vpc" "dev" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "CustomVPC"
  }
}
# IG and attach to vpc
resource "aws_internet_gateway" "name" {
  vpc_id = aws_vpc.dev.id
  tags = {
    Name = "CustomIG"
  }
}
# Subnets
resource "aws_subnet" "name" {
  vpc_id            = aws.dev.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "CustomSubnet"
  }
}
# Route Tables
resource "aws_route_table" "name" {
  vpc_id = aws_vpc.dev.id
  # Edit routes
  route {
    cidr_block = "0.0.0/0"
    gateway_id = aws_internet_gateway.name.id
  }
}

# Subnet associations
resource "aws_route_table_association" "name" {
  subnet_id      = aws_subnet.name.id
  route_table_id = aws_route_table.name.id

}
# Create Security Group

resource "aws_security_group" "sg" {
  name   = "CustomSG"
  vpc_id = aws_vpc.dev.id

  ingress {
    description = "TLS from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # -1 means all protocols
    cidr_blocks = ["0.0.0.0/0"]
  }

}
# Launch Server
resource "aws_instance" "name" {
  ami                         = "ami-09e6f87a47903347c"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.name.id
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.sg.id]
}
