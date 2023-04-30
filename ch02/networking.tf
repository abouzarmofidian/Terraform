#VPC
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "vpc"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "igw"
  }
}


#Public Subnet1
resource "aws_subnet" "public_subnet1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_subnet1_cidr
  map_public_ip_on_launch = true
  availability_zone       = var.subnet1_availability_zone
  depends_on              = [aws_vpc.vpc]

  tags = {
    Name = "public_subnet1"
  }
}

#Public Subnet2
resource "aws_subnet" "public_subnet2" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_subnet2_cidr
  map_public_ip_on_launch = true
  availability_zone       = var.subnet2_availability_zone
  depends_on              = [aws_vpc.vpc]

  tags = {
    Name = "public_subnet2"
  }

}

#Private Subnet1
resource "aws_subnet" "private_subnet1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.private_subnet1_cidr
  map_public_ip_on_launch = true
  availability_zone       = var.subnet1_availability_zone
  depends_on              = [aws_vpc.vpc]

  tags = {
    Name = "private_subnet1"
  }
}

#Private Subnet2
resource "aws_subnet" "private_subnet2" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.private_subnet2_cidr
  map_public_ip_on_launch = true
  availability_zone       = var.subnet2_availability_zone
  depends_on              = [aws_vpc.vpc]

  tags = {
    Name = "private_subnet2"
  }
}

#Route table
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = var.route_table_cidr
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public_route_table"
  }
}

resource "aws_route_table_association" "public_subnet1_association" {
  subnet_id      = aws_subnet.public_subnet1.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public_subnet2_association" {
  subnet_id      = aws_subnet.public_subnet2.id
  route_table_id = aws_route_table.public_route_table.id
}