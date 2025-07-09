# VPC
resource "aws_vpc" "dev" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "CustomVPC"
  }
}
# IG and attach to vpc
resource "aws_internet_gateway" "IG" {
  vpc_id = aws_vpc.dev.id
  tags = {
    Name = "CustomIG"
  }
}
# Subnets
resource "aws_subnet" "pub-subnet" {
  vpc_id            = aws_vpc.dev.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "CustomSubnet"
  }
}
# Route Tables
resource "aws_route_table" "pub-rt" {
  vpc_id = aws_vpc.dev.id
  # Edit routes
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IG.id
  }
}

# Subnet associations
resource "aws_route_table_association" "pub-rt-association" {
  subnet_id      = aws_subnet.pub-subnet.id
  route_table_id = aws_route_table.pub-rt.id

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
# key-pair
resource "aws_key_pair" "name" {
  key_name   = "test-key1"
  public_key = file("~/.ssh/id_ed25519.pub") # Ensure you have a public key at this path
}
# Launch Server
resource "aws_instance" "name" {
  ami                         = "ami-09e6f87a47903347c"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.pub-subnet.id
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.sg.id]
  key_name                    = aws_key_pair.name.key_name
  # key_name                    = "<your-existing-key-pair-name>" # if we want to use existing key-pair then remove the above key-pair resource
  tags = {
    Name = "CustomInstance"
  }
}



# create Private server and give secure internet to instance through NAT Gateway
# create PVT subnet
resource "aws_subnet" "pvt-subnet" {
  vpc_id     = aws_vpc.dev.id
  cidr_block = "10.0.1.0/24"
  tags = {
    Name = "Custom-PrivateSubnet"
  }
  availability_zone = "us-east-1b"
}
# create Elastic IP for NAT Gateway
resource "aws_eip" "nat_eip" {
  domain = "vpc"
}
# create NAT Gateway
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.pub-subnet.id
  depends_on    = [aws_internet_gateway.IG] # Ensure IG is created before NAT Gateway

}
# create PVT route table
resource "aws_route_table" "pvt-rt" {
  vpc_id = aws_vpc.dev.id
  # edit route
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }
}
# subnet association
resource "aws_route_table_association" "pvt-rt-association" {
  subnet_id      = aws_subnet.pvt-subnet.id
  route_table_id = aws_route_table.pvt-rt.id
}
# launch PVT server in PVT subnet
resource "aws_instance" "pvt_instance" {
  ami                    = "ami-09e6f87a47903347c"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.pvt-subnet.id
  vpc_security_group_ids = [aws_security_group.sg.id]
  # associate_public_ip_address = false # This instance will not have a public IP
  key_name = aws_key_pair.name.key_name
  tags = {
    Name = "CustomPrivateInstance"
  }
}
