# Terraform_Examples

Examples for terraform usage.

## 安装

- 在 <https://www.terraform.io/downloads> 下载对应的可执行文件

- 把 `terraform` 可执行程序添加到 `PATH`

- 配置 Provide Cache - Windows

  - 新增 Provide Cache 目录，例如：`D:\terraform\cache`

  - 在系统 `%APPDATA%` 目录下新增/编辑 `terraform.rc` 文件，内容如下：

``` text
plugin_cache_dir = "D:\\terraform\\cache"

provider_installation {
    filesystem_mirror {
        path = "D:\\terraform\\cache"
    }
}
```

- 配置 Provide Cache - Linux

  - 新增 Provide Cache 目录，例如：`$HOME/plugin-cache`

  - 在 `$HOME` 下新增/编辑 `.terraformrc` 文件，内容如下：

``` text
plugin_cache_dir = "$HOME/plugin-cache"

provider_installation {
    filesystem_mirror {
        path = "$HOME/plugin-cache"
    }
}
```

## 使用

- 初始化

``` bash
terraform init
```

- 查看执行计划

``` bash
terraform plan -var-file="values.tfvars"
```

- 安装

``` bash
terraform apply -var-file="values.tfvars" -auto-approve
```

- 修改

``` bash
# 查看修改内容
terraform plan -var-file="values.tfvars"

# 执行修改
terraform apply -var-file="values.tfvars" -auto-approve
```

- 卸载

``` bash
terraform destroy -var-file="values.tfvars" -auto-approve
```

- 添加/修改指定模块

``` bash
terraform apply -target="module.xxx" -var-file="values.tfvars"
```

- 卸载指定模块

``` bash
terraform apply -destroy -target="module.xxx" -var-file="values.tfvars"
```
