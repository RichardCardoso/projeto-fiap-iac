resource "aws_api_gateway_authorizer" "projeto_fiap_authorizer" {
  name                            = "projeto-fiap-authorizer"
  rest_api_id                     = aws_api_gateway_rest_api.this.id
  authorizer_uri                  = var.lambda_invoke_arn
  authorizer_credentials          = var.lambda_role_arn
  authorizer_result_ttl_in_seconds = 0  # You can set this to a non-zero value to cache authorizer responses.
  identity_source                 = "method.request.header.Authorization"
  type                            = "TOKEN"  # TOKEN for an authorization token, REQUEST for request parameters.

  # The lambda function should allow the API Gateway service to invoke it.
  depends_on = [aws_lambda_permission.api_gateway]
}