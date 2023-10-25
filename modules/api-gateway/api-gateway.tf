resource "aws_api_gateway_vpc_link" "this" {
  name        = "vpc-link-for-nlb"
  description = "VPC Link for Kubernetes NLB"
  target_arns = [var.nlb_arn]
}

resource "aws_api_gateway_rest_api" "this" {
  name        = "ProjetoFiapAPI"
  description = "ProjetoFiap API"
}

resource "aws_api_gateway_method" "proxy" {
  rest_api_id   = aws_api_gateway_rest_api.this.id
  resource_id   = aws_api_gateway_resource.this.id
  http_method   = "ANY"
  authorization = "NONE"

  request_parameters = {
    "method.request.path.proxy" = true
  }
}

resource "aws_api_gateway_resource" "this" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  parent_id   = aws_api_gateway_rest_api.this.root_resource_id
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_integration" "this" {
  rest_api_id             = aws_api_gateway_rest_api.this.id
  resource_id             = aws_api_gateway_resource.this.id
  http_method             = aws_api_gateway_method.proxy.http_method
  type                    = "HTTP_PROXY"
  uri                     = "http://${var.nlb_dns_name}/{proxy}"
  integration_http_method = "ANY"
  connection_type         = "VPC_LINK"
  connection_id           = aws_api_gateway_vpc_link.this.id
  request_parameters = {
    "integration.request.path.proxy" = "method.request.path.proxy"
  }
}

resource "aws_api_gateway_deployment" "api_projetofiap" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  stage_name  = "prod"
  depends_on  = [aws_api_gateway_integration.this]
}

resource "aws_api_gateway_stage" "prod" {
  deployment_id = aws_api_gateway_deployment.api_projetofiap.id
  rest_api_id   = aws_api_gateway_rest_api.this.id
  stage_name    = "prod"
  cache_cluster_enabled     = false
}