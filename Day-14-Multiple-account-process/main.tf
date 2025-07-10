provider "aws" {
  profile = "dev"
  alias   = "account1"
}

provider "aws" {
  profile = "test"
  alias   = "account2"


}

resource "aws_s3_bucket" "name" {
  bucket   = "mumbai-hyd-bucket-naresssh"
  provider = aws.account2

}
resource "aws_s3_bucket" "test" {
  bucket   = "us-hyd-bucket-nareshhhh"
  provider = aws.account1

}

#if we want to create resource in multiple account then we can use this method.
# we must have to configure accounts
# aws configure --profile dev 

#same here also
# aws configure --profile test


#?                 Extra

# if we want to delete from terraform state and keep in the remote then we can use this command to delete from state ony
# for example we want to delete secrets from terraform state and keep in the remote because secrets already configure in remote (rds),
#! terraform state rm aws_secretsmanager_secret.my_secret
#! terraform state rm aws_secretsmanager_secret_version.my_secret_version
