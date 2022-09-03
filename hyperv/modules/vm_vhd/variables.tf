variable "name" {
  type        = string
  nullable    = false
  description = "VM name"
}

variable "switch" {
  type        = string
  nullable    = false
  description = "Switch name"
}

variable "vhd_size" {
  type        = number
  nullable    = false
  description = "Size of vhd"
  default     = 107374182400              # 100 GB
}

variable "generation" {
  type        = number
  nullable    = false
  description = "Generation of VM"
  default     = 2
}

variable "cpu" {
  type        = number
  nullable    = false
  description = "CPU processor count"
  default     = 1                          # 1 core
}

variable "memory" {
  type        = number
  nullable    = false
  description = "Memory"
  default     = 2147483648                 # 2 GB
}

variable "os" {
  type        = string
  nullable    = false
  description = "Operation system"
}

variable "template" {
  type        = string
  nullable    = false
  description = "Template name of vhd"
}