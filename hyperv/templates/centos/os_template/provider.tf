provider "hyperv" {
  user            = var.username
  password        = var.password
  host            = var.host
  port            = 5985
  https           = false
  insecure        = true
  use_ntlm        = true
  timeout         = "30s"
}

terraform {
  required_providers {
    hyperv = {
      version = "1.0.3"
      source  = "taliesins/hyperv"
    }
  }
}