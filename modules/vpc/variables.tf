variable "cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for the public subnets"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "List of CIDR blocks for the private subnets"
  type        = list(string)
}

variable "candidate_ip" {
  description = "Candidate's IP address for SSH access"
  type        = string
}