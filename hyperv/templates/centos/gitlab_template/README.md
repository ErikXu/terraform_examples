# Gitlab 模板

制作 Gitlab 模板

## 事前准备

- 先制造好 `os_template` 模板，并存放在 `E:\templates\centos\os_template\Virtual Hard Disks\os_template.vhdx` 目录

- 在 `Hyper-V` 创建好交换机（Swich），名称为 `Virtual Switch`

## Terraform

- 初始化

``` bash
terraform init
```

- 查看执行计划

``` bash
terraform plan -var-file="gitlab.tfvars"
```

- 安装

``` bash
terraform apply -var-file="gitlab.tfvars" -auto-approve
```

- 修改

``` bash
# 查看修改内容
terraform plan -var-file="gitlab.tfvars"

# 执行修改
terraform apply -var-file="gitlab.tfvars" -auto-approve
```

- 卸载

``` bash
terraform destroy -var-file="gitlab.tfvars" -auto-approve
```

- 卸载指定模块

``` bash
terraform apply -destroy -target="module.xxx" -var-file="gitlab.tfvars" -auto-approve
```

## Terraform 执行示例

``` powershell
PS D:\Test\terraform_examples> cd .\hyperv\templates\centos\gitlab_template\
PS D:\Test\terraform_examples\hyperv\templates\centos\gitlab_template> terraform init
Initializing modules...
- gitlab_template in ..\..\..\modules\vm_vhd

Initializing the backend...

Initializing provider plugins...
- Finding taliesins/hyperv versions matching "1.0.3"...
- Using taliesins/hyperv v1.0.3 from the shared cache directory

Terraform has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.

╷
│ Warning: Incomplete lock file information for providers
│
│ Due to your customized provider installation methods, Terraform was forced to calculate lock file checksums locally for the       
│ following providers:
│   - taliesins/hyperv
│
│ The current .terraform.lock.hcl file only includes checksums for windows_amd64, so Terraform running on another platform will     
│ fail to install these providers.
│ To calculate additional checksums for another platform, run:
│   terraform providers lock -platform=linux_amd64
│ (where linux_amd64 is the platform to generate)
╵


You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.

PS D:\Test\terraform_examples\hyperv\templates\centos\gitlab_template> terraform plan -var-file="gitlab.tfvars"
module.gitlab_template.data.hyperv_network_switch.default: Reading...
module.gitlab_template.data.hyperv_network_switch.default: Still reading... [10s elapsed]
module.gitlab_template.data.hyperv_network_switch.default: Read complete after 19s [id=Virtual Switch]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following   
symbols:
  + create

Terraform will perform the following actions:

  # module.gitlab_template.hyperv_machine_instance.default will be created
  + resource "hyperv_machine_instance" "default" {
      + automatic_critical_error_action         = "Pause"
      + automatic_critical_error_action_timeout = 30
      + automatic_start_action                  = "StartIfRunning"
      + automatic_start_delay                   = 0
      + automatic_stop_action                   = "Save"
      + checkpoint_type                         = "Production"
      + dynamic_memory                          = false
      + generation                              = 2
      + guest_controlled_cache_types            = false
      + high_memory_mapped_io_space             = 536870912
      + id                                      = (known after apply)
      + lock_on_disconnect                      = "Off"
      + low_memory_mapped_io_space              = 134217728
      + memory_maximum_bytes                    = 1099511627776
      + memory_minimum_bytes                    = 536870912
      + memory_startup_bytes                    = 8589934592
      + name                                    = "gitlab_template"
      + processor_count                         = 4
      + smart_paging_file_path                  = "E:\\templates\\centos\\gitlab_template"
      + snapshot_file_location                  = "E:\\templates\\centos\\gitlab_template"
      + state                                   = "Running"
      + static_memory                           = true
      + wait_for_ips_poll_period                = 5
      + wait_for_ips_timeout                    = 10
      + wait_for_state_poll_period              = 2
      + wait_for_state_timeout                  = 10

      + hard_disk_drives {
          + controller_location             = 0
          + controller_number               = 0
          + controller_type                 = "Scsi"
          + disk_number                     = 4294967295
          + maximum_iops                    = 0
          + minimum_iops                    = 0
          + override_cache_attributes       = "Default"
          + path                            = "E:\\templates\\centos\\gitlab_template\\Virtual Hard Disks\\gitlab_template.vhdx"    
          + qos_policy_id                   = "00000000-0000-0000-0000-000000000000"
          + resource_pool_name              = "Primordial"
          + support_persistent_reservations = false
        }

      + network_adaptors {
          + allow_teaming                              = "On"
          + device_naming                              = "Off"
          + dhcp_guard                                 = "Off"
          + dynamic_ip_address_limit                   = 0
          + dynamic_mac_address                        = true
          + fix_speed_10g                              = "Off"
          + ieee_priority_tag                          = "Off"
          + iov_interrupt_moderation                   = "Off"
          + iov_queue_pairs_requested                  = 1
          + iov_weight                                 = 100
          + ip_addresses                               = (known after apply)
          + ipsec_offload_maximum_security_association = 512
          + is_legacy                                  = false
          + mac_address_spoofing                       = "Off"
          + management_os                              = false
          + maximum_bandwidth                          = 0
          + minimum_bandwidth_absolute                 = 0
          + minimum_bandwidth_weight                   = 0
          + name                                       = "Wan"
          + not_monitored_in_cluster                   = false
          + packet_direct_moderation_count             = 0
          + packet_direct_moderation_interval          = 0
          + packet_direct_num_procs                    = 0
          + port_mirroring                             = "None"
          + router_guard                               = "Off"
          + storm_limit                                = 0
          + switch_name                                = "Virtual Switch"
          + virtual_subnet_id                          = 0
          + vlan_access                                = false
          + vlan_id                                    = 0
          + vmmq_enabled                               = false
          + vmmq_queue_pairs                           = 16
          + vmq_weight                                 = 100
          + vrss_enabled                               = true
          + wait_for_ips                               = false
        }

      + vm_firmware {
          + console_mode                    = "Default"
          + enable_secure_boot              = "Off"
          + pause_after_boot_failure        = "Off"
          + preferred_network_boot_protocol = "IPv4"
          + secure_boot_template            = "MicrosoftWindows"
        }
    }

  # module.gitlab_template.hyperv_vhd.default will be created
  + resource "hyperv_vhd" "default" {
      + block_size           = 0
      + exists               = (known after apply)
      + id                   = (known after apply)
      + logical_sector_size  = 0
      + path                 = "E:\\templates\\centos\\gitlab_template\\Virtual Hard Disks\\gitlab_template.vhdx"
      + physical_sector_size = 0
      + size                 = 107374182400
      + source               = "E:\\templates\\centos\\os_template\\Virtual Hard Disks\\os_template.vhdx"
      + vhd_type             = "Dynamic"
    }

Plan: 2 to add, 0 to change, 0 to destroy.

─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────── 

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run       
"terraform apply" now.
PS D:\Test\terraform_examples\hyperv\templates\centos\gitlab_template> 
```

## 设置 IP

- 动态获取 IP

  如果开启了 `DHCP`，可以使用动态获取 IP 的方式：

``` bash
# 默认网卡是 eth0，如果是其它网卡请自行调整
vi /etc/sysconfig/network-scripts/ifcfg-eth0

# 修改或新增以下条目
BOOTPROTO=dhcp
ONBOOT=yes

# 重启网络
systemctl restart network
```

- 配置静态 IP

在没有 `DHCP` 的情况下需要自行设置 IP

``` bash
cd /root

# 根据需要填写 IPADDR、NETMASK、GATEWAY、DNS 等信息
vi gen.sh
bash gen.sh

# 绑定 IP
bash bind.sh
```

## 制作步骤

参考：<https://about.gitlab.com/install/#centos-7>

- 修改主机名

``` bash
hostnamectl set-hostname gitlab
```

- 安装 Gitlab-ce

``` bash
yum install -y curl policycoreutils-python openssh-server perl

yum install -y postfix
systemctl enable postfix
systemctl start postfix

curl https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.rpm.sh | sudo bash

yum install -y gitlab-ce
```

## 解绑 IP

``` bash
bash unbind.sh
```
