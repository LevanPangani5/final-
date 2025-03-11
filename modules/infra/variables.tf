variable "env" {
  type        = string
  default = "d"
}


variable "vpc_id" {
  type        = string
}

variable "sg_alb_id" {
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






