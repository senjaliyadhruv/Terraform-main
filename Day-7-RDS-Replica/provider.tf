provider "aws" {
  alias  = "primary"
  region = "us-east-1" # Source region (Mumbai)
}

provider "aws" {
  #   alias  = "secondary"
  region = "us-west-2" # Destination region (Oregon)
}
