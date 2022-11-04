output internet_gateway_id {
    value = aws_internet_gateway.terraform_internet_gateway.id
}



output public_route_table_id {
    value = aws_route_table.terraform_public_route_table.id
}

output terraform_public_subnet_a_id {
    value = aws_subnet.terraform_public_subnet_a.id
}

