# Hyper-V

- 使用的 Provider

  <https://registry.terraform.io/providers/taliesins/hyperv/latest/docs>

- 前期准备

``` shell
# Enable WinRM with negotiate authentication support
Enable-PSRemoting -SkipNetworkProfileCheck -Force

Set-WSManInstance WinRM/Config/WinRS -ValueSet @{MaxMemoryPerShellMB = 1024}
Set-WSManInstance WinRM/Config -ValueSet @{MaxTimeoutms=1800000}
Set-WSManInstance WinRM/Config/Client -ValueSet @{TrustedHosts="*"}
Set-WSManInstance WinRM/Config/Service/Auth -ValueSet @{Negotiate = $true}

# ----------------------------------------------------
# WinRM allow HTTP
# Get the public networks
$PubNets = Get-NetConnectionProfile -NetworkCategory Public -ErrorAction SilentlyContinue 

# Set the profile to private
foreach ($PubNet in $PubNets) {
    Set-NetConnectionProfile -InterfaceIndex $PubNet.InterfaceIndex -NetworkCategory Private
}

# Configure winrm
Set-WSManInstance WinRM/Config/Service -ValueSet @{AllowUnencrypted = $true}

# Restore network categories
foreach ($PubNet in $PubNets) {
    Set-NetConnectionProfile -InterfaceIndex $PubNet.InterfaceIndex -NetworkCategory Public
}

Get-ChildItem wsman:\localhost\Listener\ | Where-Object -Property Keys -eq 'Transport=HTTP' | Remove-Item -Recurse
New-Item -Path WSMan:\localhost\Listener -Transport HTTP -Address * -Force -Verbose

Restart-Service WinRM -Verbose

New-NetFirewallRule -DisplayName "Windows Remote Management (HTTP-In)" -Name "WinRMHTTPIn" -Profile Any -LocalPort 5985 -Protocol TCP -Verbose
```

- 参考资料

  <https://github.com/taliesins/terraform-provider-hyperv>
