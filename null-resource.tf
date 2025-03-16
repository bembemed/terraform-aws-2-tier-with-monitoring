resource "null_resource" "testing" {
  depends_on = [module.bastion-ec2]
  connection {
    host        = module.bastion-ec2.public_ip[0]
    type        = "ssh"
    user        = "ubuntu"
    password    = ""
    private_key = file("project-key.pem")
  }
  provisioner "file" {
    source      = "project-key.pem"
    destination = "/tmp/project-key.pem"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod 400 /tmp/project-key.pem",
    ]


  }

  # provisioner "local-exec" {
  #   command = "ssh -i /tmp/private_key.pem ec2-user@${module.bastion-ec2.public_ip} 'echo Hello, World!'"
  #   working_dir = "${path.module}"
  #   when = destroy

  # }

}