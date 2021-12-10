resource "aws_subnet" "arunkumar_public_subnet1" {
  vpc_id     = aws_vpc.arunkumar_vpc.id
  cidr_block = "110.0.1.0/24"

  tags = {
    Name = "arunkumar_public_subnet1"
  }
}
resource "aws_subnet" "arunkumar_public_subnet2" {
  vpc_id     = aws_vpc.arunkumar_vpc.id
  cidr_block = "110.0.2.0/24"

  tags = {
    Name = "arunkumar_public_subnet2"
  }
}