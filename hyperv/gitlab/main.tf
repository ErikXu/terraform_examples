module "gitlab" { 
  source   = "../modules/vm_vhd"
  name     = "gitlab"
  switch   = "Virtual Switch"
  cpu      = 4                                     # 4 Core
  memory   = 8589934592                            # 8 GB
  os       = var.os
  template = "gitlab_template"
  vhd_size = var.vhd_size
}