# Gitlab

## 事前准备

- 先制造好 `gitlab_template` 模板，并存放在 `E:\templates\centos\gitlab_template\Virtual Hard Disks\gitlab_template.vhdx` 目录

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
terraform apply -destroy -target="module.xxx" -var-file="gitlab.tfvars"
```

## 设置 IP

- 动态获取 IP

  如果开启了 DHCP，可以使用动态获取 IP 的方式：

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

在没有 DHCP 的情况下需要自行设置 IP

``` bash
cd /root

# 根据需要填写 IPADDR、NETMASK、GATEWAY、DNS 等信息
vi gen.sh
bash gen.sh

# 绑定 IP
bash bind.sh
```

## 启动配置

- 关闭防火墙

``` bash
systemctl stop firewalld
systemctl disable firewalld
```

- 配置域名

  这里的示例域名是: www.example.com

``` bash
# 修改 external_url 的值为：http://www.example.com
vi /etc/gitlab/gitlab.rb

# 重新生成相关配置文件
gitlab-ctl reconfigure
```

- 登录

  首次登录需要使用 `root` 账号，初始密码在 gitlab 服务器的 `/etc/gitlab/initial_root_password` 路径，由于初始密码在 24 小时内会过期，首次登录请修改密码

``` bash
cat /etc/gitlab/initial_root_password
```

- 配置 https - 可选

  参考：<https://docs.gitlab.com/omnibus/settings/ssl.html#configure-https-manually>

  如果是 `pfx` 证书需要做证书转换：

``` bash
# 准备 ssl 证书，这里是 gitlab.pfx，并上传到以下目录
mkdir -p /etc/gitlab/ssl

# 证书转换
cd /etc/gitlab/ssl
openssl pkcs12 -in gitlab.pfx -nodes -out www.example.com.pem
openssl rsa -in www.example.com.pem -out www.example.com.key
openssl x509 -in www.example.com.pem -out www.example.com.crt

# 修改 gitlab 配置
vi /etc/gitlab/gitlab.rb

# 内容如下
external_url 'https://www.example.com'
letsencrypt['enable'] = false

# 重新生成相关配置文件
gitlab-ctl reconfigure
```

- 配置 LDAP - 可选

  参考：<https://docs.gitlab.com/ee/administration/auth/ldap/#configure-ldap>

  修改 /etc/gitlab/gitlab.rb 里 `LDAP` 模块配置，大括号 {} 内容根据实际提供，内容参考：

``` bash
gitlab_rails['ldap_enabled'] = true
gitlab_rails['prevent_ldap_sign_in'] = false

###! **remember to close this block with 'EOS' below**
gitlab_rails['ldap_servers'] = YAML.load <<-'EOS'
  main: # 'main' is the GitLab 'provider ID' of this LDAP server
    label: 'LDAP'
    host: '{LDAP 服务器或地址}'
    port: 389
    uid: 'sAMAccountName'
    bind_dn: '{LDAP 账号完整 DN}'
    password: '{LDAP 密码}'
    encryption: 'plain' # "start_tls" or "simple_tls" or "plain"
#    verify_certificates: true
#    smartcard_auth: false
    active_directory: true
    allow_username_or_email_login: false
#    lowercase_usernames: false
#    block_auto_created_users: false
    base: '{LDAP base 路径}'
    user_filter: ''
#    ## EE only
#    group_base: ''
#    admin_group: ''
#    sync_ssh_keys: false
#
# 以下为备用 LDAP，没有可以不提供
  secondary: # 'secondary' is the GitLab 'provider ID' of second LDAP server
    label: 'LDAP'
    host: '{备用 LDAP 服务器或地址}'
    port: 389
    uid: 'sAMAccountName'
    bind_dn: '{LDAP 账号完整 DN}'
    password: '{LDAP 密码}'
    encryption: 'plain' # "start_tls" or "simple_tls" or "plain"
#    verify_certificates: true
#    smartcard_auth: false
    active_directory: true
    allow_username_or_email_login: false
#    lowercase_usernames: false
#    block_auto_created_users: false
    base: '{LDAP base 路径}'
    user_filter: ''
#    ## EE only
#    group_base: ''
#    admin_group: ''
#    sync_ssh_keys: false
EOS
```  

``` bash
# 重新生成相关配置文件
gitlab-ctl reconfigure
```
