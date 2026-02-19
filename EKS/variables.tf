variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}


variable "private_subnets" {
  description = "subnets CIDR"
  type        = list(string)
}

variable "public_subnets" {
  description = "subnets CIDR"
  type        = list(string)
}