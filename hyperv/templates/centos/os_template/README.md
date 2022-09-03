# CentOS 系统模板

制作 Hyper-V CentOS 系统模板

## 事前准备

- 存放 `CentOS-7-x86_64-Minimal-2009.iso` 镜像到 `E:\iso\CentOS-7-x86_64-Minimal-2009.iso` 路径下

- 创建好 `E:\templates\centos` 目录

- 在 `Hyper-V` 创建好交换机（Swich），名称为 `Virtual Switch`

## Terraform

- 初始化

``` bash
terraform init
```

- 查看执行计划

``` bash
terraform plan -var-file="os.tfvars"
```

- 安装

``` bash
terraform apply -var-file="os.tfvars" -auto-approve
```

- 修改

``` bash
# 查看修改内容
terraform plan -var-file="os.tfvars"

# 执行修改
terraform apply -var-file="os.tfvars" -auto-approve
```

- 卸载

``` bash
terraform destroy -var-file="os.tfvars" -auto-approve
```

- 卸载指定模块

``` bash
terraform apply -destroy -target="module.xxx" -var-file="os.tfvars" -auto-approve
```

## Terraform 执行示例

``` powershell
PS D:\Test\terraform_examples> cd .\hyperv\templates\centos\os_template\
PS D:\Test\terraform_examples\hyperv\templates\centos\os_template> terraform init
Initializing modules...
- os_template in ..\..\..\modules\vm_iso

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
│ Due to your customized provider installation methods, Terraform was forced to calculate lock file checksums locally for the following providers:   
│   - taliesins/hyperv
│
│ The current .terraform.lock.hcl file only includes checksums for windows_amd64, so Terraform running on another platform will fail to install      
│ these providers.
│
│ To calculate additional checksums for another platform, run:
│   terraform providers lock -platform=linux_amd64
│ (where linux_amd64 is the platform to generate)
╵

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.

PS D:\Test\terraform_examples\hyperv\templates\centos\os_template> terraform plan -var-file="os.tfvars"
module.os_template.data.hyperv_network_switch.default: Reading...
module.os_template.data.hyperv_network_switch.default: Still reading... [10s elapsed]
module.os_template.data.hyperv_network_switch.default: Read complete after 18s [id=Virtual Switch]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # module.os_template.hyperv_machine_instance.default will be created
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
      + name                                    = "os_template"
      + processor_count                         = 4
      + smart_paging_file_path                  = "E:\\templates\\centos\\os_template"
      + snapshot_file_location                  = "E:\\templates\\centos\\os_template"
      + state                                   = "Running"
      + static_memory                           = true
      + wait_for_ips_poll_period                = 5
      + wait_for_ips_timeout                    = 10
      + wait_for_state_poll_period              = 2
      + wait_for_state_timeout                  = 10

      + dvd_drives {
          + controller_location = 0
          + controller_number   = 0
          + path                = "E:\\iso\\CentOS-7-x86_64-Minimal-2009.iso"
        }

      + hard_disk_drives {
          + controller_location             = 1
          + controller_number               = 0
          + controller_type                 = "Scsi"
          + disk_number                     = 4294967295
          + maximum_iops                    = 0
          + minimum_iops                    = 0
          + override_cache_attributes       = "Default"
          + path                            = "E:\\templates\\centos\\os_template\\Virtual Hard Disks\\os_template.vhdx"
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

  # module.os_template.hyperv_vhd.default will be created
  + resource "hyperv_vhd" "default" {
      + block_size           = 0
      + exists               = (known after apply)
      + id                   = (known after apply)
      + logical_sector_size  = 0
      + path                 = "E:\\templates\\centos\\os_template\\Virtual Hard Disks\\os_template.vhdx"
      + physical_sector_size = 0
      + size                 = 107374182400
      + vhd_type             = "Dynamic"
    }

Plan: 2 to add, 0 to change, 0 to destroy.

──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────── 

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now. 
PS D:\Test\terraform_examples\hyperv\templates\centos\os_template>
```

## 时区

虚拟机创建完成制作 vhd 时，根据需要设置操作系统时区，比如东八区

## 网络

虚拟机创建完成制作 vhd 时，设置 `Ethernet` 为 `ON`

## 分区

虚拟机创建完成制作 vhd 时，建议按如下配置设置分区

| 目录 | 建议大小 |
| ------- | ------- |
| /boot | 1024 MiB |
| /boot/efi | 200 MiB |
| swap | 根据内存大小划分，一般可以等于内存 |
| / | 剩余的所有大小 |

## 准备静态 IP 脚本

如果没有 `DHCP`，制作 `vhd` 时，建议先做好 `eth0` 配置的模板，方便后续绑定 IP

- centos_template 绑定 IP

``` bash
# 默认网卡是 eth0，如果是其它网卡请自行调整
cd  /etc/sysconfig/network-scripts
cp ifcfg-eth0 ifcfg-eth0.bak
vi ifcfg-eth0

# 修改或新增以下条目
BOOTPROTO=static
ONBOOT=yes
IPADDR={IP Address}
NETMASK={Net Mask}
GATEWAY={Gateway}
DNS1={DNS1}

# 重启网络
systemctl restart network
```

- 用 ssh 终端登录 centos_template，并在 `root` 添加以下`gen.sh`，`bind.sh`，`unbind.sh` 三个脚本

gen.sh：

``` bash
cat <<EOF > ifcfg-eth0
TYPE=Ethernet
PROXY_METHOD=none
BROWSER_ONLY=no
BOOTPROTO=static
DEFROUTE=yes
IPV4_FAILURE_FATAL=no
IPV6INIT=yes
IPV6_AUTOCONF=yes
IPV6_DEFROUTE=yes
IPV6_FAILURE_FATAL=no
IPV6_ADDR_GEN_MODE=stable-privacy
NAME=eth0
UUID=$(uuidgen)
DEVICE=eth0
ONBOOT=yes
IPADDR=
NETMASK=255.255.255.0
GATEWAY=
DNS1=
EOF
```

bind.sh：

``` bash
cp /etc/sysconfig/network-scripts/ifcfg-eth0 /etc/sysconfig/network-scripts/ifcfg-eth0.bak

mv -f ifcfg-eth0 /etc/sysconfig/network-scripts/ifcfg-eth0

systemctl restart network
```

unbind.sh：

``` bash
cd /etc/sysconfig/network-scripts
mv -f ifcfg-eth0.bak ifcfg-eth0

systemctl restart network
```

## 更新 Yum 源

``` bash
yum install -y epel-release
yum update -y
```

## 安装常用工具

``` bash
yum install -y net-tools wget htop ngrep
```

## 解绑 IP

``` bash
bash unbind.sh
```
