> 主推工作流：Windows10/11 + WSL2 + Docker + Neovim v0.12+ + Claude Code
>
> 如果使用Linux作为日常主力机操作系统，可跳过Windows + WSL，直接构建Docker + Neovim + Claude Code工作流
>
> 如果使用MacOS作为日常主力机操作系统，可跳过Windows + WSL，构建其他虚拟机 + Docker + Neovim + Claude Code工作流

- Windows10/11: 主力机操作系统
- WSL2：运行Docker环境
- Docker：运行开发环境
- Neovim v0.12+：代码编辑器
- Claude Code：Agent

# 环境准备

## Windows10/11
- 开启WSL
> 自行处理，一般需要开启“适用于Linux的Windows子系统”和“虚拟机平台”并重启电脑

## Linux

## MacOS
 
# 工作流构建步骤
 
## Windows10/11
- 安装Alpine WSL虚拟机
> https://github.com/yuk7/AlpineWSL

- 安装ukyang0623/dotfile 
> 下载ukyang0623/dotfile代码，放入Alpine WSL虚拟机中（建议放在家目录下） 
> 执行代码库中的scripts/wsl/alpine.sh脚本
> 会要求填写一些参数，按需填写即可。包括：
> 1. 用户名（英文）
> 2. 用户名（中文）
> 3. 用户邮箱
> 4. HTTP/HTTPS代理

- 重启Alpine WSL虚拟机

- 构建Docker镜像并运行开发容器
> 进入Alpine WSL虚拟机中的代码库docker目录下
> 执行命令：docker compose up -d

- 安装Neovim插件
> 执行dev命令进入开发容器
> 在开发容器环境中执行nv命令即可进入Neovim并自动开始安装插件

## Linux

## MacOS
