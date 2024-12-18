variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_subnets" {
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnets" {
  default = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "ami_id" {
  default = "ami-061dd8b45bc7deb3d"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {
  default = "vockey"
}

variable "alb_name" {
  default = "wordpress-alb"
}

variable "db_name" {
  default = "wordpress_db"
}

variable "db_user" {
  default = "admin"
}

variable "db_password" {
  default = "securepassword"
}

variable "db_instance_class" {
  default = "db.t2.micro"
}

variable "db_allocated_storage" {
  default = 20
}
