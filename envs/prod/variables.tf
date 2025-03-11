
variable "vpc_cidr" {
    type =string
    default = "172.31.168.64/26"
}

variable "sbn_1a_priv_cidr" {
  type =string
  default = "172.31.168.64/28"
}

variable "sbn_1b_priv_cidr" {
  type =string
  default = "172.31.168.80/28"
}

variable "sbn_1a_pub_cidr" {
  type =string
  default = "172.31.168.96/28"
}

variable "sbn_1b_pub_cidr" {
  type =string
  default = "172.31.168.112/28"
}


