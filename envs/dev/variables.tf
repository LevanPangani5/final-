
variable "vpc_cidr" {
    type =string
    default = "172.31.168.0/26"
}

variable "sbn_1a_priv_cidr" {
  type =string
  default = "172.31.168.0/28"
}

variable "sbn_1b_priv_cidr" {
  type =string
  default = "172.31.168.16/28"
}

variable "sbn_1a_pub_cidr" {
  type =string
  default = "172.31.168.32/28"
}

variable "sbn_1b_pub_cidr" {
  type =string
  default = "172.31.168.48/28"
}


