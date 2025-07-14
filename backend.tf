provider "aws" {
  region = local.region
  profile = "default"
}

terraform {
  backend "s3" {
    bucket = "tech-blog-terraform"
    region = "ap-northeast-1"
    profile = "default"
    key = "prod"
    encrypt = true
  }
}

# FIXME: 取り込むこと
# resource "aws_s3_bucket" "terraform" {
#   bucket = "${local.project}-terraform"
# }
