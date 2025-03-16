variable "instance_type" {
  description = "The type of EC2 instance to launch"
  default     = "t2.micro"

}

variable "private_key_path" {
  description = "The path to the private key used to connect to the EC2 instance"
  default     = ""

}
