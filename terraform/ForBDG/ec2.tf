resource "aws_instance" "instance" {
 ami = "ami-00149760ce42c967b"
 key_name = "OHIO"
 subnet_id = "subnet-0f747280bcf8c4793"
 availability_zone = "us-east-2a"
 instance_type = "t2.micro"
 vpc_security_group_ids = [aws_security_group.terraform_SG.id]
 associate_public_ip_address = true
 user_data = "${file("data.sh")}"
}

resource "aws_ebs_volume" "volium" {
  availability_zone = "us-east-2a"
  size              = 10
  type              = "gp2"
  tags = {
    Name = "Hello"
  }
}

resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.volium.id
  instance_id = aws_instance.instance.id
}


