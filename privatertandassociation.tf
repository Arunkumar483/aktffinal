# private route-table
resource "aws_route_table" "arunkumar_private_rt" {
  vpc_id = aws_vpc.arunkumar_vpc.id
  tags = {
    Name = "arunkumar_private_rt"
  }
}
# privateRT - 2 private subnets association
resource "aws_route_table_association" "arunkumar_rta3" {
  subnet_id      = aws_subnet.arunkumar_private_subnet1.id
  route_table_id = aws_route_table.arunkumar_private_rt.id
}
resource "aws_route_table_association" "arunkumar_rta4" {
  subnet_id      = aws_subnet.arunkumar_private_subnet2.id
  route_table_id = aws_route_table.arunkumar_private_rt.id
}