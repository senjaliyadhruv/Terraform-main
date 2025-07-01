module "mymod" {
  source        = "<GITHUB SOURCE URL>" #its take the source from github
  instance_type = "t2.micro"
  ami_id        = "ami-05ffe3c48a9991133"
  # aws_region    = "us-east-1"
}
