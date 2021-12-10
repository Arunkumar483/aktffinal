resource "aws_subnet" "arunkumar_private_subnet1" {
  vpc_id     = aws_vpc.arunkumar_vpc.id
  cidr_block = "110.0.3.0/24"

  tags = {
    Name = "arunkumar_private_subnet1"
  }
}
resource "aws_subnet" "arunkumar_private_subnet2" {
  vpc_id     = aws_vpc.arunkumar_vpc.id
  cidr_block = "110.0.4.0/24"

  tags = {
    Name = "arunkumar_private_subnet2"
  }
}