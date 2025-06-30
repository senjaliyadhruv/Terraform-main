
module "web_instance" {
  source        = "./modules/ec2-instance"
  ami_id        = var.ami
  instance_type = var.instance_type
  instance_name = var.instance_name
}
