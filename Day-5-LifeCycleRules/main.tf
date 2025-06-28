resource "aws_instance" "name" {
  ami               = "ami-09e6f87a47903347c" # Replace with a valid AMI ID
  instance_type     = "t2.micro"              # Replace with the desired instance type
  availability_zone = "us-east-1a"

  tags = {
    Name = "MyInstance"
  }
  #   lifecycle {
  #     prevent_destroy = true # This will prevent the instance from being destroyed
  #   }

  #   lifecycle {
  #     ignore_changes = [tags, ] #this will ignore to change the tags if anyone changes it by remote 
  #   }

    # lifecycle {
    #   create_before_destroy = true # This will create a new instance before destroying the old one
    # }

}

