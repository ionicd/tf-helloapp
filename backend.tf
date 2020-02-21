terraform {
  backend "s3" {
    bucket = "tf-bk"
    key    = "terraform/dev/helloapp"
    region = "us-east-1"
  }
}
