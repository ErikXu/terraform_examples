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
