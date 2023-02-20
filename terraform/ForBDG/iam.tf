
resource "aws_iam_role" "instance" {
  name               = "instance"
  path               = "/system/"
  assume_role_policy = data.aws_iam_policy_document.instance_assume_role_policy.json
}


resource "aws_iam_role_policy" "s3-full" {
  name   = "s3_full_access_tf"  
  role   = aws_iam_role.instance.id
  policy = data.aws_iam_policy_document.s3_access.json
}

resource "aws_iam_instance_profile" "my_prof" {
  name = "my_prof"  
  role = aws_iam_role.instance.name

}

data "aws_iam_policy_document" "instance_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "s3_access" {
  statement {
    effect    = "Allow"
    actions   = ["s3:*"]
    resources = ["*"]
  }
}