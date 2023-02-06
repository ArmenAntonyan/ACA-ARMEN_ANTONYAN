variable "ami" {
  description = "ami for instance" 
  type        = string 
  }

  variable "key" {
  description = "kay Ohio"
  type        = string 
  }

  variable "sub_id" {
  description = "subnet_id"
  type        = string 
  }

  variable "AZ" {
  description = "avaliablity zone"
  type        = string 
  }

  variable "itipe" {
  description = "instance type"
  type        = string 
  }

  variable "ebs_size" {
  description = "aws_ebs_volume_size"
  type        = number 
  }

  variable "ebs_typ" {
  description = "type of aws ebs typ"
  type        = string 
  }

 variable "aws_vol_device_name" {
  description = "volum name"
  type        = string 
  }

  variable "SG_VPC_id" {
  description = "sg vpc id "
  type        = string 
  }

  variable "SG_rule_type" {
  description = "sg rule type"
  type        = string 
  }

  variable "SG_rule_protocol" {
  description = "protocol"
  type        = string 
  }

  variable "ping" {
  description = "protocol for ping"
  type        = string 
  }

variable "aws_region" {
  description = "region aws"
  type        = string 
  }
