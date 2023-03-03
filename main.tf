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

#Internet Gateway
resource "aws_internet_gateway" "my-internet-gateway" {
  vpc_id = aws_vpc.my-vpc.id
  tags = {
    Name = var.internet_gateway_name
  }
}

# Route Table
resource "aws_default_route_table" "default_route" {
  default_route_table_id = aws_vpc.my-vpc.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my-internet-gateway.id
  }
}