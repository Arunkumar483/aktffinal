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

