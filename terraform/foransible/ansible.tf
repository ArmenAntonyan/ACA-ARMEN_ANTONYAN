terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "us-east-2"
}

resource "aws_vpc" "terraform_VPC" {
  cidr_block = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "terraform VPC"
  }
}


resource "aws_subnet" "terraform_subnet" {
  vpc_id     = aws_vpc.terraform_VPC.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-2a"
  map_public_ip_on_launch = true
  tags = {
    Name = "terraform subnetpub"
  }
}

resource "aws_internet_gateway" "terraformIGW" {
  vpc_id = aws_vpc.terraform_VPC.id

  tags = {
    Name = "VPC-IGW"
  }
}

resource "aws_route_table" "terraformRT" {
  vpc_id = aws_vpc.terraform_VPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.terraformIGW.id
  }
}


resource "aws_route_table_association" "rout_assoc1" {
  subnet_id      = aws_subnet.terraform_subnet.id
  route_table_id = aws_route_table.terraformRT.id
}


resource "aws_instance" "instance" {
 ami = "ami-00149760ce42c967b"
 subnet_id = aws_subnet.terraform_subnet.id
 key_name = "OHIO"
 availability_zone = "us-east-2a"
 instance_type = "t2.micro"
 associate_public_ip_address = true
 vpc_security_group_ids = [aws_security_group.terraform_SG.id]  

}

resource "aws_security_group" "terraform_SG" {
  name        = "web_server "
  description = "TASC web server"
  vpc_id      = aws_vpc.terraform_VPC.id


  dynamic "ingress" {
    for_each = ["80", "22"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]

    }
  }

  egress {
    description = "Allow ALL ports"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }
  tags = {
    Name = "terraform_SG"
  }
}
output "instance_ip_addr" {
  value = aws_instance.instance.public_ip
}
