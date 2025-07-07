provider "aws" {

}

data "aws_subnet" "name" {
  filter {
    name   = "tag:Name"
    values = ["subnet-dev"] # insert value here
  }
}
data "aws_ami" "amzlinux" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-gp2"]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

# data "aws_ami" "amzlinux" {
#   most_recent = true
#   owners = [ "self" ]
#  filter {
#     name   = "name"
#     values = ["ami-node1"]
#   }
# }

resource "aws_instance" "name" {
  ami           = data.aws_ami.amzlinux.id
  instance_type = "t2.micro"
  subnet_id     = data.aws_subnet.name.id

}








# +----------------------+---------------------------------------------------------+---------------------------------------------------------------+
# | Feature              | Data Source                                             | Import                                                        |
# +----------------------+---------------------------------------------------------+---------------------------------------------------------------+
# | Purpose              | Read data from existing infrastructure resources        | Bring existing resources under Terraform management           |
# +----------------------+---------------------------------------------------------+---------------------------------------------------------------+
# | Usage                | Read-only; cannot modify the resource                   | Full management (read, update, destroy) after import          |
# +----------------------+---------------------------------------------------------+---------------------------------------------------------------+
# | Syntax               | Uses `data` block in Terraform configuration            | Uses `terraform import` command                               |
# +----------------------+---------------------------------------------------------+---------------------------------------------------------------+
# | Resource State       | Does NOT add full resource to Terraform state           | Adds the resource to the state file                           |
# +----------------------+---------------------------------------------------------+---------------------------------------------------------------+
# | Resource Definition  | Configuration must match the resource being referenced  | Configuration must match the imported resource                |
# +----------------------+---------------------------------------------------------+---------------------------------------------------------------+
# | Lifecycle Management | Terraform cannot manage lifecycle of the resource       | Terraform can manage full lifecycle after import              |
# +----------------------+---------------------------------------------------------+---------------------------------------------------------------+
# | Example              | data "aws_vpc" "example" { ... }                        | terraform import aws_vpc.example vpc-123456                   |
# +----------------------+---------------------------------------------------------+---------------------------------------------------------------+
# | Use Case             | Refer to resources not managed by Terraform             | Manage pre-existing infrastructure with Terraform             |
# +----------------------+---------------------------------------------------------+---------------------------------------------------------------+
