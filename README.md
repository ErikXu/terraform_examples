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
