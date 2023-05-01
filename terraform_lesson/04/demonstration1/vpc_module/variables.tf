variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"
}

variable "vpc_subnet_name" {
  type = string
  default = "develop-ru-central1-a"
}

variable "zone" {
  type = string
  default = "ru-central1-a"
}

variable "cidr" {
  type = list
  default = ["10.0.1.0/24"]
}
