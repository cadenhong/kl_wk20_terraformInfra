# OUTPUT
output "vpc_id" {
  value = aws_vpc.practice-vpc.id
}

output "igw_id" {
  value = aws_internet_gateway.practice-ig.id
}

output "subnet1_id" {
  value = aws_subnet.subnet1.id
}

output "subnet2_id" {
  value = aws_subnet.subnet2.id
}

output "rt_id" {
  value = aws_route_table.route_table1.id
}