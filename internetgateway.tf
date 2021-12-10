# internet-gateway
resource "aws_internet_gateway" "arunkumar_ig" {
  vpc_id = aws_vpc.arunkumar_vpc.id
  tags = {
    Name = "arunkumar_ig"
  }
}