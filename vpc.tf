resource "aws_vpc" "arunkumar_vpc" {
  cidr_block       = "110.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "arunkumar_vpc"
  }
}