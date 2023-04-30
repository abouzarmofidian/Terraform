variable "region" {
  type    = string
  default = "us-west-2"
}

variable "access_key" {
  type    = string
  default = "default"
}

variable "secret_key" {
  type    = string
  default = "default"
}

variable "vpc_cidr" {
  type    = string
  default = "10.10.0.0/16"
}

variable "public_subnet1_cidr" {
  type    = string
  description = "Public Subnet 1 cidr block"
  default = "10.10.1.0/24"
}

variable "subnet1_availability_zone" {
  type    = string
  default = "us-west-2-a"
}

variable "public_subnet2_cidr" {
  type    = string
  description = "Public Subnet 2 cidr block"
  default = "10.10.2.0/24"
}

variable "subnet2_availability_zone" {
  type    = string
  default = "us-west-2-b"
}

variable "private_subnet1_cidr" {
   type = string
   description = "Private Subnet 1 cidr block"
   default = "10.10.3.0/24"  
}

variable "private_subnet2_cidr" {
   type = string
   description = "Private Subnet 2 cidr block"
   default = "10.10.4.0/24"  
}

variable "route_table_cidr" {
  type        = string
  description = "cidr block for public route table"
  default     = "0.0.0.0/0"
}

variable "ami_id" {
  type        = string
  description = "var for AMI ID"
  default     = "ami-069aabeee6f53e7bf"
}

variable "instance_type" {
  type        = string
  description = "var for instance type"
  default     = "t2.micro"
}

variable "cidr_open" {
  type        = string
  default     = "0.0.0.0/0"
}