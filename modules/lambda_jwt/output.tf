output "lambda_invoke_arn" {
  value = aws_lambda_function.terraform_lambda_jwt.invoke_arn
  description = "O ARN usado para invocar a função Lambda"
}