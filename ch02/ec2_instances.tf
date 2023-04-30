resource "aws_instance" "instance1" {
    ami                    = var.ami_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.web_server_sg.id]
  user_data              = file("apache.sh")
  subnet_id              = aws_subnet.public_subnet1.id
  key_name               = "two_tier"

  tags = {
    Name = "instance1"
  }
  
}

resource "aws_instance" "instance2" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.web_server_sg.id]
  user_data              = file("apache.sh")
  subnet_id              = aws_subnet.public_subnet2.id

  tags = {
    Name = "instance2"
  }
}