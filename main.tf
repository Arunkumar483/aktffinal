provider "aws" {
  region  = "us-east-1"
}

resource "aws_vpc" "arunkumar_vpc" {
  cidr_block       = "110.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "arunkumar_vpc"
  }
}
# internet-gateway
resource "aws_internet_gateway" "arunkumar_ig" {
  vpc_id = aws_vpc.arunkumar_vpc.id
  tags = {
    Name = "arunkumar_ig"
  }
}

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
# private route-table
resource "aws_route_table" "arunkumar_private_rt" {
  vpc_id = aws_vpc.arunkumar_vpc.id
  tags = {
    Name = "arunkumar_private_rt"
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
# privateRT - 2 private subnets association
resource "aws_route_table_association" "arunkumar_rta3" {
  subnet_id      = aws_subnet.arunkumar_private_subnet1.id
  route_table_id = aws_route_table.arunkumar_private_rt.id
}
resource "aws_route_table_association" "arunkumar_rta4" {
  subnet_id      = aws_subnet.arunkumar_private_subnet2.id
  route_table_id = aws_route_table.arunkumar_private_rt.id
}
# instances
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




resource "aws_lb" "arunkumar-alb" {
  name               = "arunkumar-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.arunkumar-ec2sg.id]
  subnets            = [aws_subnet.arunkumar_public_subnet1.id, aws_subnet.arunkumar_public_subnet2.id]
  enable_deletion_protection = false
  tags = {
    Name = "arunkumar-alb"
    createdby = "amohandas@presidio.com"
  }
}
resource "aws_lb_target_group" "arunkumar-tg" {
  name     = "arunkumar-tg"
  port     = 80
  protocol = "HTTP"
  target_type = "instance"
  vpc_id   = aws_vpc.arunkumar_vpc.id
}
resource "aws_lb_target_group_attachment" "arunkumar-tga1" {
  target_group_arn = aws_lb_target_group.arunkumar-tg.arn
  target_id        = aws_instance.arunkumar_instance1.id
  port             = 80
}
resource "aws_lb_target_group_attachment" "arunkumar-tga2" {
  target_group_arn = aws_lb_target_group.arunkumar-tg.arn
  target_id        = aws_instance.arunkumar_instance1.id
  port             = 80
}
resource "aws_lb_listener" "arunkumar-lblistener" {
  load_balancer_arn = aws_lb.arunkumar-alb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.arunkumar-tg.arn
  }
}



resource "aws_db_instance" "default" {
  allocated_storage    = 20
  identifier           = "arunkumar-db"
  engine               = "mysql"
  engine_version       = "8.0.23"
  instance_class       = "db.t3.micro"
  name                 = "mydb"
  username             = "arunkumar"
  password             = "arunkumar"
  port                 = "3306"
  db_subnet_group_name = aws_db_subnet_group.arunkumar-subgroup.name
  skip_final_snapshot  = true
  vpc_security_group_ids = [aws_security_group.arunkumar-mysqlsg.id]
}
resource "aws_db_subnet_group" "arunkumar-subgroup" {
  name       = "arunkumar-subgroup"
  subnet_ids = [aws_subnet.arunkumar_private_subnet1.id, aws_subnet.arunkumar_private_subnet2.id]
  tags = {
    Name = "arunkumar-subgroup"
  }
}




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