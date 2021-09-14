
variable "prefix" {
  default = "brokentable-proxy"
}

variable "project" {
  default = "fec-brokentable-proxy"
}

variable "INSTANCE_TYPE" {
  default = "t2.micro"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "devkey.pub"
}

variable "AWS_REGION" {
  default = "us-west-2"
}