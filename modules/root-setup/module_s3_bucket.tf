module "state" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = var.state_bucket_name
  acl    = "private"

  policy        = data.aws_iam_policy_document.s3.json
  attach_policy = true

  versioning = {
    enabled = true
  }

  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm     = "aws:kms"
        kms_master_key_id = aws_kms_key.this.arn
      }
    }
  }
}

data "aws_iam_policy_document" "s3" {

  statement {
    sid = "Allow reading this terraform state to members of organization"
    principals {
      type        = "AWS"
      identifiers = formatlist("arn:aws:iam::%s:root", [for k, v in aws_organizations_account.this : v.id])
    }

    actions   = ["s3:GetObject"]
    effect    = "Allow"
    resources = [format("%s/%s/%s", module.state.s3_bucket_arn, var.state_bucket_path, "terraform.tfstate")]
  }
}
