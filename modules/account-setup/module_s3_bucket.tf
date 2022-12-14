module "state" {
  source = "terraform-aws-modules/s3-bucket/aws"

  count = var.create_state_bucket ? 1 : 0

  bucket = var.state_bucket_name
  acl    = "private"

  versioning = {
    enabled = true
  }

  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm     = "aws:kms"
        kms_master_key_id = aws_kms_key.this[0].arn
      }
    }
  }
}
