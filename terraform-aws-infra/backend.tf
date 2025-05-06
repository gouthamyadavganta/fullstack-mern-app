terraform {
  backend "s3" {
    bucket         = "goutham-devsecops-project2-dnt-tfstate"
    key            = "terraform/state/terraform.tfstate"
    region         = "us-east-2"
    dynamodb_table = "goutham-tf-dnt-locks"
    encrypt        = true
  }
}
