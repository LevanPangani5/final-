variable "vpc_cidr" {
  type        = string
}
variable "vpc_name" {
  type        = string
  default = "vpc-ec1-infra"
}


variable "sbn_1a_priv_name" {
  type        = string
  default = "sbn-ec1-1a-priv"
}
variable "sbn_1a_priv_cidr" {
  type        = string
}


variable "sbn_1b_priv_name" {
  type        = string
  default = "sbn-ec1-1b-priv"
}

variable "sbn_1b_priv_cidr" {
  type        = string
}


variable "sbn_1a_pub_name" {
  type        = string
  default = "sbn-ec1-1a-pub"
}
variable "sbn_1a_pub_cidr" {
  type        = string
}


variable "sbn_1b_pub_name" {
  type        = string
  default = "sbn-ec1-1b-pub"
}
variable "sbn_1b_pub_cidr" {
  type        = string
}


variable "nacl_name" {
  type = string
  default = "nacl-ec1-infra"
}

variable "rt_pub_name" {
  type =string
  default = "rt-ec1-pub-infra"
}

variable "rt_priv_name" {
  type =string
  default = "rt-ec1-priv-infra"
}


variable "ig_name" {
  type = string
  default = "ig-ec1-infra"
}

variable "nat_name" {
  type = string
  default = "nat-ec1-infra"
}

variable "eip_name" {
  type = string
  default = "eip-nat-ec1-infra"
}

variable "runner_vpc_id" {
  type = string
  default = "vpc-07954abc263d723da"
}

variable "runner_rt_id" {
  type = string
  default = "rtb-0c6613fe00b918750"
}

variable "runner_cidr" {
  type = string
  default = "172.31.168.128/28"
}

variable "vpc_peer_name" {
  type = string
  default = "vpc-peer-runner-infra"
}

variable "env" {
  type = string
  default = "d"
}
