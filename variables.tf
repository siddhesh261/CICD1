variable "ansibleserver_ami_var" {
  type    = string
  default = "dummyami"
}

variable "ansibleserver_instance_type" {
  type    = string
  default = "t2.micro"
}

variable "ansibleserver_kp" {
  type    = string
  default = "terra1"
}

variable "servername_var" {
  type    = string
  default = "dummy-ansibleserver"
}

variable "bucket_name" {
  type        = string
  description = "Bucket Name"
  default     = "bins3tflabbucket"
}

variable "env_type" {
  type    = string
  default = "DEV"
}

variable "ansibleserver_sg_name" {
  type    = string
  default = "ansibleserver-sg"
}
