resource "aws_instance" "instance" {
 ami = var.ami
 key_name = var.key
 subnet_id = var.sub_id
 availability_zone = var.AZ
 instance_type = var.itipe
 vpc_security_group_ids = [aws_security_group.terraform_SG.id]
 associate_public_ip_address = true
 user_data = "${file("data.sh")}"
}

resource "aws_ebs_volume" "volium" {
  availability_zone = var.AZ
  size              = var.ebs_size
  type              = var.ebs_typ
  tags = {
    Name = "Hello"
  }
}

resource "aws_volume_attachment" "ebs_att" {
  device_name = var.aws_vol_device_name
  volume_id   = aws_ebs_volume.volium.id
  instance_id = aws_instance.instance.id
}


