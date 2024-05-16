terraform {
  backend "s3" {
    bucket         = "tf-statefile-bucket-b27b997a" 
    key            = "practice/terraform.tfstate"
    region         = "ap-south-1"
    profile        = "keys"
  }
}