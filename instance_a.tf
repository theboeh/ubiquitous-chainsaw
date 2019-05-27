resource "aws_instance" "instance_a" {
  ami           = "ami-0080e4c5bc078760e"
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
  }

  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook ansible/provision_instance_a.yaml -i ${aws_instance.instance_a.public_ip}, -u ec2-user"
  }
}

output "instance_a_ip" {
  value = aws_instance.instance_a.public_ip
}
