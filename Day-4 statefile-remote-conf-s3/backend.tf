terraform {
  backend "s3" {
    bucket = "bucketforbackendstatefile"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}
