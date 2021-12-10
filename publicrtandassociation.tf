# public route-table
resource "aws_route_table" "arunkumar_public_rt" {
  vpc_id = aws_vpc.arunkumar_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.arunkumar_ig.id
  }
  tags = {
    Name = "arunkumar_public_rt"
  }
}
# publicRT - 2 public subnets association
resource "aws_route_table_association" "arunkumar_rta1" {
  subnet_id      = aws_subnet.arunkumar_public_subnet1.id
  route_table_id = aws_route_table.arunkumar_public_rt.id
}
resource "aws_route_table_association" "arunkumar_rta2" {
  subnet_id      = aws_subnet.arunkumar_public_subnet2.id
  route_table_id = aws_route_table.arunkumar_public_rt.id
}