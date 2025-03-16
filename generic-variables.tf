variable "aws_region" {
  default = "us-east-1"
  type    = string
}

variable "access_key" {
  default = ""
  type    = string
}

variable "secret_key" {
  default = ""
  type    = string
}

variable "environment" {
  default = "dev"
  type    = string
}

variable "bussiness_unit" {
  default = "IT"
  type    = string

}