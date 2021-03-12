module "ec2" {
  source = "git::https://github.com/0y0ykh3994/terraform.ide.git//ec2?ref=master"
}

resource "aws_key_pair" "default" {
  key_name	= "key.${var.resource_name}"
  public_key	= var.public_key_value
  tags = {
    Name = "key.${var.resource_name}"
  }
}

resource "aws_instance" "bastion" {
  ami				= var.bastion_ami_id
  instance_type 		= var.bastion_type
  subnet_id			= var.sub_pub2a_id
  key_name			= aws_key_pair.default.key_name
  associate_public_ip_address	= "true"
  vpc_security_group_ids = [aws_security_group.bastion.id]
#  user_data = << EOF
#			#! /bin/bash
#			useradd "${var.user_name}"
#			echo "${var.user_pass}" | passwd --stdin var.user_name
#			echo "${var.user_name} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/90-cloud-init-users
#			cp -a /home/ec2-user/.ssh /home/"${var.user_name}"
#			sed 's/PasswordAuthentication no/PasswordAuthentication yes/' -i /etc/ssh/sshd_config
#			systemctl restart sshd
#			cp -a /usr/share/zoneinfo/Asia/Seoul /etc/localtime
#
#		EOF

  root_block_device {
    volume_type		  = "gp2"
    volume_size		  = "30"
    delete_on_termination = "true"
  }
  tags = {
    Name = "ec2.bastion.${var.resource_name}"
  }
  depends_on = [aws_security_group.bastion]
}
