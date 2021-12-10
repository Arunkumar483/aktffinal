resource "aws_security_group" "arunkumar-ec2sg" {
  name        = "arunkumar-ec2sg"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.arunkumar_vpc.id
  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "TLS from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "arunkumar-ec2sg"
  }
}
# security group for rds
resource "aws_security_group" "arunkumar-mysqlsg" {
  name        = "arunkumar-mysqlsg"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.arunkumar_vpc.id
  ingress {
    description = "TLS from VPC"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.arunkumar_vpc.cidr_block]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "arunkumar-mysqlsg"
  }
}