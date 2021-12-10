resource "aws_instance" "arunkumar_instance1" {
  ami                         = "ami-0ed9277fb7eb570c9"
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.arunkumar_public_subnet1.id
  security_groups = [aws_security_group.arunkumar-ec2sg.id]
  tags = {
    Name = "arunkumar_instance1"
  }
  user_data  = file("./scripts/bootstrapcode1.sh")
  depends_on = [aws_internet_gateway.arunkumar_ig]
}
resource "aws_instance" "arunkumar_instance2" {
  ami                         = "ami-0ed9277fb7eb570c9"
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.arunkumar_public_subnet2.id
  security_groups = [aws_security_group.arunkumar-ec2sg.id]
  tags = {
    Name = "arunkumar_instance2"
  }
  user_data  = file("./scripts/bootstrapcode2.sh")
  depends_on = [aws_internet_gateway.arunkumar_ig]
}


