terraform {
  backend "s3" {
    bucket = "jenkinseks"
    key    = "jenkins/terraform.tfstate"
    region = "ap-south-1"
  }
}