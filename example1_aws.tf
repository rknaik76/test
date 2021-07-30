/*
terraform {
    required_providers {
      aws = {
        source = "hashicorp/aws" 
      }
    }
  
}

provider "aws" {
    region = "us-east-2"
}

resource "aws_instance" "myserver001" {
  ami = "ami-0233c2d874b811deb"
  instance_type = "t2.nano"
 
  tags = {
    "Name" = "myserver001"
  }

  key_name = "rknaik76"
}

output "ip_address" {
  value = aws_instance.myserver001.public_ip
}

*/