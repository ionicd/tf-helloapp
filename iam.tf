data "aws_iam_policy_document" "default" {
  statement {
    sid = "1"
    actions = [
      "s3:ListAllMyBuckets",
      "s3:GetBucketLocation",
      "s3:ListBucket",
      "s3:GetObject",
      "s3:ListObject"
    ]
    resources = [
      "arn:aws:s3:::*"
    ]
  }
}
resource "aws_iam_policy" "default" {
  name   = "tf-sb-helloapp"
  policy = "${data.aws_iam_policy_document.default.json}"
}
resource "aws_iam_role" "default" {
  name = "tf-sb-helloapp"
  assume_role_policy = <<EOF
{
      "Version": "2012-10-17",
      "Statement": [
        {
          "Action": "sts:AssumeRole",
          "Principal": {
            "Service": "ec2.amazonaws.com"
          },
          "Effect": "Allow",
          "Sid": ""
        }
      ]
    }
EOF
}
resource "aws_iam_role_policy_attachment" "default" {
  role       = "${aws_iam_role.default.name}"
  policy_arn = "${aws_iam_policy.default.arn}"
}
resource "aws_iam_instance_profile" "default" {
  name = "tf-sb-helloapp"
  role = "${aws_iam_role.default.name}"
}
