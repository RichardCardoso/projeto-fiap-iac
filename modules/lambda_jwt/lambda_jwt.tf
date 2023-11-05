resource "aws_lambda_function" "terraform_lambda_jwt" {
  function_name = var.lambda_name

  filename = "deployment_jwt.zip"

  handler = "index.handler"
  role    = "${aws_iam_role.iam_for_lambda_jwt.arn}"
  runtime = "nodejs18.x"

  environment {
    variables = {
      BD_DATABASE = var.db_endpoint
    }
  }

}

resource "aws_iam_role" "iam_for_lambda_jwt" {
  name = "iam_for_lambda_jwt"

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