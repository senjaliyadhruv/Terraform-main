provider "aws" {

}

data "aws_subnet" "name" {
  filter {
    name   = "tag:Name"
    values = ["subnet-dev"] # insert value here
  }
}
