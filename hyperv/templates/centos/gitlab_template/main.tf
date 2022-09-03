module "gitlab_template" {
  source   = "../../../modules/vm_vhd"
  name     = "gitlab_template"
  switch   = "Virtual Switch"
  cpu      = 4                                     # 4 Core
  memory   = 8589934592                            # 8 GB
  os       = "centos"
  template = "os_template"
}