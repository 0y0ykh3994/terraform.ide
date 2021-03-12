resource "aws_security_group" "bastion" {
  name		= "seg.bastion.${var.resource_name}"
  description 	= "bastion host security"
  vpc_id	= var.vpc_id

  ingress {
    description = "From any"
    from_port   = 0
    to_port	= 0
    protocol	= "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "for any"
    from_port   = 0
    to_port	= 0
    protocol	= "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "seg.bastion.${var.resource_name}"
  }
}
