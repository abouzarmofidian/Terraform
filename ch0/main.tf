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

#Public IP and add to Security Group
data "external" "myipaddr" {
  program = ["bash", "-c", "curl -s 'https://ipinfo.io/json'"]
}

#Security Group
resource "aes_security_group" "jenkins_security_group" {
  name_prefix = var.security_group_name
  description = "Jenkins EC2 instance"
  vpc_id      = aws_vpc.my-vpc.id

  ingress {
    description = "Allow SSH from my public IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow Access to Jenkins Server"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow Access to the Jenkins Server"
    from_port   = 443
    to_port     = 443
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
    Name = "Jenkins_Security_Group"
  }

}


#EC2 Instance
resource "aws_instance" "ec2_instance" {
  ami             = var.ami
  instance_type   = var.instance_type
  key_name        = var.ssh_key_name
  security_groups = [aws_security_groupp.jenkins_security_group.id]
  subnet_id       = aws_subnet.subnet.id
  user_data       = var.ec2_user_data
  tags = {
    Name = var.ec2_tag
  }
}


#S3 Bucket
resource "aws_s3_bucket" "s3" {
  bucket = var.bucket_name
  tags = {
    Name = var.bucket_name
  }

}

resource "aws_s3_bucket_acl" "jenkinsbucketacl" {
  bucket = var.bucket_name
  acl    = "private"

}
