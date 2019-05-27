data "external" "local_info" {
  program = ["./scripts/localinfo.sh"]
}

output "my_ip" {
  value = data.external.local_info.result.ip
}

output "my_hostname" {
  value = data.external.local_info.result.hostname
}

output "my_user" {
  value = data.external.local_info.result.user
}

resource "aws_security_group" "allow_myself" {
  name          = "allow_myself"
  description   = "Allow myself into servers and servers out to internet"
  depends_on    = [data.external.local_info]

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${data.external.local_info.result.ip}/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "deployer" {
  key_name = "${data.external.local_info.result.user}@${data.external.local_info.result.hostname}"
  public_key = file("~/.ssh/id_rsa.pub")
}
