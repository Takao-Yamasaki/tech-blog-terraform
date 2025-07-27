# ------------------------------
# 信頼ポリシー
# ------------------------------
data "aws_iam_policy_document" "rds_auto_stop_assume_role" {
  version = "2012-10-17"
  statement {
    principals {
      type = "Service"
      identifiers = ["scheduler.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
    effect = "Allow"
  }
}

data "aws_iam_policy_document" "rds_auto_stop_policy_document" {
  version = "2012-10-17"
  statement {
    actions = ["rds:StopDBInstance"]
    effect = "Allow"
    resources = [ "*" ]
  }
}

# ------------------------------
# IAMポリシー
# ------------------------------
resource "aws_iam_policy" "rds_auto_stop_policy" {
  name = "rds_auto_stop_policy"
  description = "policy for RDS Auto Stop"
  policy = data.aws_iam_policy_document.rds_auto_stop_policy_document.json
}

# ------------------------------
# IAMロール
# ------------------------------
resource "aws_iam_role" "rds_auto_stop_role" {
  name = "rds_auto_stop_role"
  assume_role_policy = data.aws_iam_policy_document.rds_auto_stop_assume_role.json
}

resource "aws_iam_role_policy_attachment" "rds_auto_stop_policy_attachment" {
  role       = aws_iam_role.rds_auto_stop_role.name
  policy_arn = aws_iam_policy.rds_auto_stop_policy.arn
}
