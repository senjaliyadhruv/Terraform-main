resource "aws_vpc" "dev-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "dev-vpc"
  }
}
resource "aws_subnet" "subnet-1" {
  cidr_block = "10.0.0.0/24"
  vpc_id     = aws_vpc.dev-vpc.id
  tags = {
    Name = "subnet-1"
  }

}
resource "aws_subnet" "subnet-2" {
  cidr_block = "10.0.1.0/24"
  vpc_id     = aws_vpc.dev-vpc.id
  tags = {
    Name = "subnet-2"
  }

}
