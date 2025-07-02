resource "aws_instance" "ec2" {
  ami           = "ami-0c55b159cbfafe1f0" # replace with your AMI ID
  instance_type = "t2.micro"              # replace with your instance type
  tags = {
    Name = "MyEC2Instance"
  }
  user_data = file("test.sh")
  # this test.sh file should be in the same directory as this main.tf file
  #this test.sh file should contain the commands to install and start a web server
  # and create a simple HTML file in the web server's root directory
}
