resource "aws_instance" "instance_b" {
  ami           = "ami-05a36d3b9aa4a17ac"
  instance_type = "t2.micro"

  security_groups = [aws_security_group.allow_myself.name]
  key_name        = aws_key_pair.deployer.key_name

  root_block_device {
    volume_size = 9
  }

  ebs_block_device {
    device_name = "/dev/sdb"
    volume_size = 1
    volume_type = "gp2"
    encrypted   = true
  }

  ebs_block_device {
    device_name = "/dev/sdc"
    volume_size = 1
    volume_type = "gp2"
    encrypted   = true
  }

  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook ansible/provision_instance_b.yaml -i ${aws_instance.instance_b.public_ip}, -u ubuntu"
  }

}

output "instance_b_ip" {
  value = aws_instance.instance_b.public_ip
}
