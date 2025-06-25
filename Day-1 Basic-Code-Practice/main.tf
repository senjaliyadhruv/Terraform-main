resource "aws_instance" "name" {

  # ami = "ami-09e6f87a47903347c"
  ami = var.test
  # instance_type ="t2.micro"
  instance_type = var.type
  tags = {
    Name = "test"
  }
}
