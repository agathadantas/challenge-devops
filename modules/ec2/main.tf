resource "aws_instance" "ec2" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.public_subnet_id
  security_groups = var.security_group_ids
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name
}

resource "aws_iam_role" "ec2_role" {
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_instance_profile" "ec2_profile" {
  role = aws_iam_role.ec2_role.name
}

resource "aws_iam_policy" "s3_access" {
  name   = "EC2-S3-Access"
  policy = data.aws_iam_policy_document.s3_access.json
}

data "aws_iam_policy_document" "s3_access" {
  statement {
    sid       = "AllowS3ReadWrite"
    actions   = ["s3:GetObject", "s3:PutObject"]
    resources = ["arn:aws:s3:::${var.bucket_name}/*"]
    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"
      values   = [true] 
    }
  }
}
