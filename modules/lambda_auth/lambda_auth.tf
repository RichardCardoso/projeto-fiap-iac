resource "aws_lambda_function" "terraform_lambda_auth" {
  function_name = var.lambda_name

  filename = "deployment_auth.zip"

  handler = "index.handler"
  role    = "${aws_iam_role.iam_for_lambda_auth.arn}"
  runtime = "nodejs18.x"
}

resource "aws_iam_role" "iam_for_lambda_auth" {
  name = "iam_for_lambda_auth"

  assume_role_policy = jsonencode({
  Version: "2012-10-17",
  Statement: [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
  })
}