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


resource "aws_subnet" "terraform_subnetA" {
  vpc_id     = aws_vpc.terraform_VPC.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-2a"
  map_public_ip_on_launch = true
  tags = {
    Name = "terraform subnetpub1"
  }
}


resource "aws_subnet" "terraform_subnetC" {
  vpc_id     = aws_vpc.terraform_VPC.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "us-east-2c"
  map_public_ip_on_launch = true
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


resource "aws_route_table_association" "rout_assoc1" {
  subnet_id      = aws_subnet.terraform_subnetA.id
  route_table_id = aws_route_table.terraformRT.id
}

resource "aws_route_table_association" "rout_assoc2" {
  subnet_id      = aws_subnet.terraform_subnetC.id
  route_table_id = aws_route_table.terraformRT.id
}

resource "aws_launch_template" "asa-templ" {
  name = "templ"
  image_id = "ami-00149760ce42c967b"
  instance_type = "t2.micro"
  key_name = "OHIO"
  vpc_security_group_ids = [aws_security_group.terraform_SG.id]
    tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "test"
    }
}
user_data = filebase64("${path.module}/data.sh")
}
#resource "aws_launch_configuration" "as_conf" {
#  name_prefix   = "myapp-template"
#  image_id      = "ami-00149760ce42c967b"
#  instance_type = "t2.micro"
#  security_groups = [aws_security_group.terraform_SG.id]
#  user_data = <<EOF
#!/bin/bash
#apt-get -y update
#apt-get -y install nginx
#echo "<h1>Hello World from $(hostname -f)</h1>" > 
/var/www/html/index.html
#echo fin v1.00!
#EOF
#}

resource "aws_autoscaling_group" "bar" {
  name                 = "terraform-asg-example"
  min_size             = 2
  max_size             = 3
  vpc_zone_identifier  = [aws_subnet.terraform_subnetC.id, 
aws_subnet.terraform_subnetA.id]
launch_template {
    id      = aws_launch_template.asa-templ.id
  }
}


# resource "aws_instance" "instance" {
#  ami = "ami-00149760ce42c967b"
#  subnet_id = aws_subnet.terraform_subnetA.id
#  availability_zone = "us-east-2a"
#  instance_type = "t2.micro"
#  vpc_security_group_ids = [aws_security_group.terraform_SG.id]  
#  user_data = <<EOF
# !/bin/bash
# apt-get -y update
# apt-get -y install nginx
# echo "<h1>Hello World from $(hostname -f)</h1>" > 
/var/www/html/index.html
# echo fin v1.00!
# EOF

#tags = {
 #   Name = "terraform-ins"
 # }
#  user_data = "${file("USERDATA.sh")}"
#}

#resource "aws_eip" "IP" {
#  instance = aws_instance.instance.id
#  vpc      = true
#}

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


resource "aws_lb_target_group" "lb-tg" {
  name     = "lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id = aws_vpc.terraform_VPC.id
  target_type  = "instance"
   health_check {
    path = "/"
    interval = 5
    timeout = 4
    healthy_threshold = 5
    unhealthy_threshold = 2
}
}
 resource "aws_lb" "terraform-lb" {
  name = "terraform-lb"
  internal = false
  load_balancer_type = "application"
  security_groups = [aws_security_group.terraform_SG.id]
  subnets = [aws_subnet.terraform_subnetA.id, 
aws_subnet.terraform_subnetC.id]
  }
 resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.terraform-lb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
   target_group_arn = aws_lb_target_group.lb-tg.arn
  }
}

resource "aws_autoscaling_attachment" "asg_attachment_bar" {
  autoscaling_group_name = aws_autoscaling_group.bar.name
  lb_target_group_arn    = aws_lb_target_group.lb-tg.arn
}

