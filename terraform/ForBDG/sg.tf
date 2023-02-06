resource "aws_security_group" "terraform_SG" {
  name        = "web_server "
  description = "TASC web server"
  vpc_id      = var.SG_VPC_id


egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}
  resource "aws_security_group_rule" "in_ssh" {
  type              = var.SG_rule_type
  from_port         = 0
  to_port           = 22
  protocol          = var.SG_rule_protocol
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.terraform_SG.id
}

resource "aws_security_group_rule" "in_http" {
  type              = var.SG_rule_type
  from_port         = 0
  to_port           = 80
  protocol          = var.SG_rule_protocol
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.terraform_SG.id
}

resource "aws_security_group_rule" "in_https" {
  type              = var.SG_rule_type
  from_port         = 0
  to_port           = 443
  protocol          = var.SG_rule_protocol
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.terraform_SG.id
}

resource "aws_security_group_rule" "in_icmp" {
  type              = var.SG_rule_type
  from_port         = -1
  to_port           = -1
  protocol          = var.ping
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.terraform_SG.id
}

