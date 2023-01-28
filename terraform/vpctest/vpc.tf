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

#data "http" "myip" {
#  url = "http://ipv4.icanhazip.com"
#}


resource "aws_vpc" "terraform_VPC" {
  cidr_block = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "terraform VPC"
  }
}


resource "aws_subnet" "terraform_subnetA" {
  vpc_id     = aws_vpc.terraform_VPC.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-2a"
  tags = {
    Name = "terraform subnetpub1"
  }
}


resource "aws_subnet" "terraform_subnetC" {
  vpc_id     = aws_vpc.terraform_VPC.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "us-east-2c"
  tags = {
    Name = "terraform subnetpub2"
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


resource "aws_route_table_association" "rout_assoc" {
  subnet_id      = aws_subnet.terraform_subnetA.id
  route_table_id = aws_route_table.terraformRT.id
# gateway_id     = aws_internet_gateway.terraformIGW.id
}




resource "aws_instance" "instance" {
  ami = "ami-00149760ce42c967b"
  subnet_id = aws_subnet.terraform_subnetA.id
  availability_zone = "us-east-2a"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.terraform_SG.id]  
  user_data = <<EOF
#!/bin/bash
apt-get -y update
apt-get -y install nginx
echo "<h1>Hello World from $(hostname -f)</h1>" > /var/www/html/index.html
echo fin v1.00!
EOF

tags = {
    Name = "terraform-ins"
  }
#  user_data = "${file("USERDATA.sh")}"
}

resource "aws_eip" "IP" {
  instance = aws_instance.instance.id
  vpc      = true
}

resource "aws_security_group" "terraform_SG" {
  name        = "terraform_SG"
  description = "Allow inbound traffic"
  vpc_id      = aws_vpc.terraform_VPC.id

  ingress {
    description      = "TLS from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }


  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "terraform_SG"
  }
}
