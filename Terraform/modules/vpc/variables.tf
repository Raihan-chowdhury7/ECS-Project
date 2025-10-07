variable "tags" {
  description = "Common tags to apply to all resources in this module"
  type        = map(string)
  default     = {}
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type = string
}

variable "vpc_name" {
  description = "Name of the VPC"
  type = string
}

variable "azs" {
  description = "List of availability zones to use"
  type        = list(string)
}

variable "public_subnets" {
  description = "Map of two public subnets"
  type = map(string) 
}
