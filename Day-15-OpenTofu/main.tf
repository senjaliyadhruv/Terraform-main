#OpenTofu is the alternate tool of Terraform.
#fully Open source IaC tool.
#all command are same 
resource "aws_instance" "question" {
  ami           = "ami-00a929b66ed6e0de6"
  instance_type = "t2.micro"
}
