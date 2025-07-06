variable "ami" {
  type    = string
  default = "ami-0440d3b780d96b29d"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "env" {
  type    = list(string)
  default = ["one", "three"] #[ "one", "two", "three"] when we delete "two" then only delete "two" 
}

resource "aws_instance" "sandbox" {
  ami           = var.ami
  instance_type = var.instance_type
  for_each      = toset(var.env)
  #   count = length(var.env)  

  tags = {
    Name = each.value # for a set, each.value and each.key is the same
  }
}
