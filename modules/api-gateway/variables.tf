variable "nlb_arn" {}
variable "nlb_dns_name" {}
variable "nlb_wait_trigger" {
  description = "Trigger to create a dependency on the NLB availability"
  type        = map(string)
}

variable "lambda_jwt_name" {}
variable "lambda_auth_name" {}

variable "lambda_invoke_arn" {
  description = "ARN for invoking the Lambda function"
  type        = string
}

variable "lambda_role_arn" {}

variable "lambda_auth_invoke_arn" {}

variable "lambda_auth_role_arn" {}