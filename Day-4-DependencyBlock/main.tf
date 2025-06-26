resource "aws_instance" "test" {
  ami           = "ami-09e6f87a47903347c"
  instance_type = "t2.micro"
  tags = {
    Name = "test"
  }
}
resource "aws_vpc" "test_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "test-vpc"
  }
  depends_on = [aws_instance.test]
  // The 'depends_on' block ensures that the VPC is created only after the instance is created.
  //due to depends_on, the VPC will be created after the instance is created.
}
