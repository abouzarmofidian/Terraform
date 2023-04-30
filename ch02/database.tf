resource "aws_db_subnet_group" "subnet_group" {
  name       = "subnet_group"
  subnet_ids = [aws_subnet.private_subnet2.id, aws_subnet.private_subnet1.id]

  tags = {
    Name = "My DB subnet group"
  }
}


resource "aws_db_instance" "instance_db" {
  allocated_storage    = 10
  db_name              = "instance_db"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  username             = "admin"    
  password             = "password"
  skip_final_snapshot  = true
  publicly_accessible = false
  vpc_security_group_ids = [aws_security_group.database_sg.id]
  availability_zone      = var.subnet1_availability_zone
  db_subnet_group_name = "subnet_group"
  port = "3306"
  
  }