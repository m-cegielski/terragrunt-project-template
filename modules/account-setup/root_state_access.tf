resource "aws_iam_policy" "root_access" {
  count = length(keys(var.users)) > 0 ? 1 : 0

  name   = "root_state_access"
  policy = data.aws_iam_policy_document.root_access_policy.json
}

data "aws_iam_policy_document" "root_access_policy" {
  statement {
    sid    = "AllowAccessToRootState"
    effect = "Allow"
    actions = [
      "s3:GetObject"
    ]
    resources = [var.root_state_file_arn]
  }

  statement {
    sid    = "AllowDecryption"
    effect = "Allow"
    actions = [
      "kms:Decrypt"
    ]
    resources = [var.root_state_kms_key]
  }
}


