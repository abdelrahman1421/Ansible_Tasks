resource "aws_internet_gateway" "terraform_internet_gateway" {
  vpc_id = var.vpc_id
  tags = {
    Name = "Terraform Internet Gateway"
  }
  depends_on = [aws_subnet.terraform_public_subnet_a]
}