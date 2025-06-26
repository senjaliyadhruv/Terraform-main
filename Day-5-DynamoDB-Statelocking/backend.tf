terraform {
  backend "s3" {
    bucket         = "bucketforbackendstatefile"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-lock" # DynamoDB table for state locking 
    encrypt        = true                   // Enable server-side encryption
  }
}

// if we keep same path for backend.tf file, it will override the previous state file
// so we need to change the path of backend.tf file
// or we can change the bucket name in backend.tf file
// it will delete the resources which are existing in the previous state file
// and create new resources in the new state file

//we can change the path or name of the bucket


# terraform {
#   backend "s3" {
#     bucket = "bucketforbackendstatefile"
#     key    = "day-4/terraform.tfstate"
#     region = "us-east-1"
#   }
# }

//this will create a new state file in the day-4 folder
// and will not override the previous state file
