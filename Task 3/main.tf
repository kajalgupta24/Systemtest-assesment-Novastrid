provider "aws" {
  region = var.region
}

resource "aws_instance" "web" {
  ami           = var.ami
  instance_type = var.instance_type

  tags = {
    Name = "WebServer"
  }
}

resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name
  acl    = "private"
}

variable "region" {
  default = "ap-south-1"
}

variable "ami" {
  default = "ami-0c02fb55956c7d"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "bucket_name" {
  default = "my-assessment-test"
}

terraform {
  backend "s3" {
    bucket         = "my-assessment-test"
    key            = "state/terraform.tfstate"
    region         = "ap-south-1"
  }
}
