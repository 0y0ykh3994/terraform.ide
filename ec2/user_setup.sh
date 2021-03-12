#!/bin/bash

useradd var.user_name
echo "${var.user_pass}" | passwd --stdin var.user_name
echo "${var.user_name} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/90-cloud-init-users
cp -a /home/ec2-user/.ssh /home/var.user_name

sed 's/PasswordAuthentication no/PasswordAuthentication yes/' -i /etc/ssh/sshd_config
systemctl restart sshd

cp -a /usr/share/zoneinfo/Asia/Seoul /etc/localtime
