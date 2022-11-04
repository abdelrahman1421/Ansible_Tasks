resource "aws_instance" "terraform_proxy_a" {
  ami                         = var.instance_ami_a
  subnet_id                   = var.terraform_public_subnet_a_id
  instance_type               = var.instance_type
  key_name                    = var.ssh_key
  vpc_security_group_ids      = [var.vpc_security_group_ids]
  associate_public_ip_address = true

  root_block_device {
    volume_type           = "gp2"
    volume_size           = "8"
    delete_on_termination = true
  }

  provisioner "local-exec" {
    command = "sed -i 's/ubuntu_ip/${self.public_ip}/' ../ansiblerole/host_var/ubuntu.domain.com.yml"
  }
  tags = {
    Name = "Terraform Proxy_A"
  }
}


  resource "aws_instance" "terraform_proxy_b" {
    ami                         = var.instance_ami_b
    subnet_id                   = var.terraform_public_subnet_a_id
    instance_type               = var.instance_type
    key_name                    = var.ssh_key
    vpc_security_group_ids      = [var.vpc_security_group_ids]
    associate_public_ip_address = true

    root_block_device {
      volume_type           = "gp2"
      volume_size           = "10"
      delete_on_termination = true
    }

    provisioner "local-exec" {

    command = "sed -i 's/redhat_ip/${self.public_ip}/' ../ansiblerole/host_var/RedHat.domain.com.yml"

  }
    tags = {
      Name = "Terraform Proxy_B"
    }
}

  resource "aws_instance" "terraform_proxy_c" {
    ami                         = var.instance_ami_c
    subnet_id                   = var.terraform_public_subnet_a_id
    instance_type               = var.instance_type
    key_name                    = var.ssh_key
    vpc_security_group_ids      = [var.vpc_security_group_ids]
    associate_public_ip_address = true

    root_block_device {
      volume_type           = "gp2"
      volume_size           = "8"
      delete_on_termination = true
    }

    provisioner "local-exec" {

    command = "sed -i 's/amazon_ip/${self.public_ip}/' ../ansiblerole/host_var/amazon.domain.com.yml"

  }
    tags = {
      Name = "Terraform Proxy_C"
    }
}