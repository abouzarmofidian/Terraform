#VPC
resource "aws_vpc" "my-vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = var.vpc_name
  }
}

#Subnet
resource "aws_subnet" "my-subnet" {
  vpc_id                  = aws_vpc.my-vpc.id
  availability_zone       = var.availability_zone
  cidr_block              = var.subnet_cidr
  map_public_ip_on_launch = true
  tags = {
    Name = var.subnet_name
  }

}