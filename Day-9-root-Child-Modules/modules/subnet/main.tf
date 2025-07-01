data "aws_vpc" "default_vpc" {
  default = true
}

resource "aws_subnet" "pub-subnet" {
  vpc_id            = data.aws_vpc.default_vpc.id
  cidr_block        = var.cidr_subnet
  availability_zone = var.az
  tags              = var.tags
}
