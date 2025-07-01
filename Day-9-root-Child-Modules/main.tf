module "web_server" {
  source        = "./modules/ec2-instance"
  ami_id        = "ami-05ffe3c48a9991133"
  instance_type = "t2.micro"
  instance_name = "web-server"
}

module "subnet" {
  source      = "./modules/subnet"
  cidr_subnet = "172.31.250.0/28"
  az          = "us-east-1c"
  tags = {
    Name = "Terraform-Subnet"
  }


}
