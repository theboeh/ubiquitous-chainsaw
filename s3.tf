resource "aws_kms_key" "s3_key" {
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = 10
}

resource "aws_s3_bucket" "bucket" {
  bucket = "${data.external.local_info.result.user}.${data.external.local_info.result.hostname}.inivog"
  acl    = "private"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = "${aws_kms_key.s3_key.arn}"
        sse_algorithm     = "aws:kms"
      }
    }
  }

  policy = <<POLICY
{
  "Id": "Policy1558979140397",
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Stmt1558979136958",
      "Action": "s3:*",
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::${data.external.local_info.result.user}.${data.external.local_info.result.hostname}.inivog",
      "Condition": {
        "Bool": {
          "aws:SecureTransport": "true"
        }
      },
      "Principal": "*"
    }
  ]
}
POLICY
}

resource "aws_s3_bucket_public_access_block" "s3_access_block" {
  bucket = "${aws_s3_bucket.bucket.id}"

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

output "s3_bucket" {
  value  = aws_s3_bucket.bucket.id
}
