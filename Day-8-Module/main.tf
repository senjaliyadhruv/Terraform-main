module "mymod" {
  source        = "../Day-8-modules-source"
  instance_type = "t2.micro"
  ami_id        = "ami-05ffe3c48a9991133"
  # aws_region    = "us-east-1"
}
