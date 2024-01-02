variable "username" {
  type        = string
  description = "Unifi administrative username for terraform user"
  default     = "terraform"
}

variable "password" {
  type        = string
  description = "Unifi administrative password for terraform user"
  //Add this to terraform.tfvars or handle securely
}

variable "api_url" {
  type        = string
  description = "Unifi Console Management IP"
  default     = "https://192.168.1.1"
}

variable "insecure" {
  type        = bool
  description = "Allow insecure connection (ignore cert errors)"
  default     = true
}

variable "blackhole_cidr" {
  type        = string
  description = "CIDR to blackhole route"
  default     = "8.8.8.8/32"
}
