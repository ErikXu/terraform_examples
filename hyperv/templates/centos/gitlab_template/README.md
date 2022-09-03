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
