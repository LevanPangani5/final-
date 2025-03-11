variable "env" {
  type        = string
  default = "d"
}


variable "vpc_id" {
  type        = string
}

variable "sbn_1a_pub_id" {
  type        = string
}


variable "sbn_1b_pub_id" {
  type        = string
}

variable "sbn_1a_priv_id" {
  type        = string
}


variable "sbn_1b_priv_id" {
  type        = string
}



variable "alb_name" {
  type        = string
  default = "alb_ec1_infra"
}

variable "tg_name" {
  type        = string
  default = "tg-ec1-infra-web"
}



variable "sg_name_website" {
  type =string
  default = "sec-gr-ec1-1a-web"
}

variable "sg_name_redis" {
  type =string
  default = "sec-gr-ec1-1a-redis"
}

variable "sg_name_alb" {
  type =string
  default = "sec-gr-ec1-1a-alb"
}


variable "ami_website" {
  type = string
  default = "ami-07eef52105e8a2059"
}

variable "instance_type_website" {
  type = string
  default = "t3.medium"
}

variable "ami_redis" {
  type = string
  default = "ami-07eef52105e8a2059"
}

variable "instance_type_website" {
  type = string
  default = "t3.medium"
}






