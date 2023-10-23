resource "aws_lambda_function" "terraform_lambda" {
  function_name = var.lambda_name

  filename = "lambda.zip"

  handler = "index.handler"
  role    = "${aws_iam_role.iam_for_lambda.arn}"
  runtime = "nodejs18.x"
}

resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"

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