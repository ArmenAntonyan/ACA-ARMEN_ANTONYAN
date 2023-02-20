resource "aws_s3_bucket" "hrashq" {
  bucket = var.s3_bucket_name
  
}

resource "aws_s3_bucket_acl" "example" {
  bucket = aws_s3_bucket.hrashq.id
  acl    = var.acl
}

resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.hrashq.id
  versioning_configuration {
    status = "Enabled"
  }
}