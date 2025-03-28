data "aws_ami" "amzlinux" {
  # most_recent = true

  # owners = ["099720109477"]
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-20250115"]
  }



  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }


}

output "name" {
  value = data.aws_ami.amzlinux.name

}