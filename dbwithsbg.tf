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
