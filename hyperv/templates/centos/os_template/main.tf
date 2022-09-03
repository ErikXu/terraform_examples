module "os_template" {
  source  = "../../../modules/vm_iso"
  name    = "os_template"
  switch  = "Virtual Switch"
  cpu     = 4                                     # 4 Core
  memory  = 8589934592                            # 8 GB
  iso     = "CentOS-7-x86_64-Minimal-2009.iso"
  os      = "centos"
}