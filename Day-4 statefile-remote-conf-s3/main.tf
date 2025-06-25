resource "aws_vpc" "dev-vpc" {
  cidr_block = "10.0.0.0/16"
}
resource "aws_subnet" "subnet-1" {
  cidr_block = "10.0.0.0/24"
  vpc_id     = aws_vpc.dev-vpc.id

}
resource "aws_subnet" "subnet-2" {
  cidr_block = "10.1.0.0/24"
  vpc_id     = aws_vpc.dev-vpc.id

}
