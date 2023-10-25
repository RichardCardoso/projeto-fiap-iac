variable "nlb_arn" {}
variable "nlb_dns_name" {}
variable "nlb_wait_trigger" {
  description = "Trigger to create a dependency on the NLB availability"
  type        = map(string)
}