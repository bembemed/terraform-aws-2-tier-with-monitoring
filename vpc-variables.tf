variable "vpc-name" {
  default = "vpc-it"

}

variable "vpc_cidr_block" {
  default = "10.2.0.0/16"

}

variable "vpc_availability_zones" {
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
  type    = list(string)

}

variable "vpc_public_subnets" {
  default = ["10.2.1.0/24", "10.2.2.0/24"]

}
variable "vpc_private_subnets" {
  default = ["10.2.10.0/24", "10.2.20.0/24"]

}

variable "vpc_database_subnets" {
  default = ["10.2.100.0/24", "10.2.200.0/24"]

}

