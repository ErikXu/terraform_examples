data "hyperv_network_switch" "default" {
  name = var.switch
}

resource "hyperv_vhd" "default" {
  path = "E:\\templates\\${var.os}\\${var.name}\\Virtual Hard Disks\\${var.name}.vhdx"
  size = var.vhd_size
}

resource "hyperv_machine_instance" "default" {
  name = var.name
  generation = var.generation
  static_memory = true
  processor_count = var.cpu
  memory_startup_bytes = var.memory
  smart_paging_file_path = "E:\\templates\\${var.os}\\${var.name}"
  snapshot_file_location = "E:\\templates\\${var.os}\\${var.name}"
  wait_for_state_timeout = 10
  wait_for_ips_timeout   = 10

  vm_firmware {
    enable_secure_boot = "Off"
  }

  dvd_drives {
    controller_number = 0
    controller_location = 0
    path = "E:\\iso\\${var.iso}"
  }

  hard_disk_drives {
    controller_type     = "Scsi"
    path                = hyperv_vhd.default.path
    controller_number   = 0
    controller_location = 1
  }

  network_adaptors {
    name = "Wan"
    switch_name  = data.hyperv_network_switch.default.name
    wait_for_ips = false
  }
}