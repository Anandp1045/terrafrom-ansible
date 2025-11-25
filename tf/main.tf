# ami-0fa91bc90632c73c9

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "eu-north-1" # Replace with your desired AWS region
}


resource "aws_security_group" "mysecuritygroup" {
  name        = "my-security-group"
  description = "Allow HTTP and SSH access"

  ingress {
    description = "Allow HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  ingress {
    description = "Allow ssh from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # Represents all protocols
    cidr_blocks = ["0.0.0.0/0"]

  }
}


resource "aws_instance" "my_instance" {
  ami           = "ami-0fa91bc90632c73c9"
  instance_type = "t3.micro"
  tags = {
    Ansible = "Ansible"
    Name = "Ansible"
  }

  key_name               = "MyFirstKeypair"
  vpc_security_group_ids = [aws_security_group.mysecuritygroup.id]

  availability_zone = "eu-north-1b"

}

output "aws_public_ip" {
  value = aws_instance.my_instance.public_ip
}