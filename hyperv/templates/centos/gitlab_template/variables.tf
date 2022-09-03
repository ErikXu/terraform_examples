variable "host" {
  type        = string
  nullable    = false
  description = "The IP address of physical machine"
}

variable "username" {
  type        = string
  nullable    = false
  description = "Login username"
}

variable "password" {
  type        = string
  nullable    = false
  description = "Login password"
}