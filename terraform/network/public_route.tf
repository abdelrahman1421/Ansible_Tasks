resource "aws_route_table" "terraform_public_route_table" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.terraform_internet_gateway.id
  }
  tags = {
    Name = "Terraform Public Route Table"
  }
}



resource "aws_route_table_association" "terraform_public_route_a" {
  subnet_id      = aws_subnet.terraform_public_subnet_a.id
  route_table_id = aws_route_table.terraform_public_route_table.id
}

