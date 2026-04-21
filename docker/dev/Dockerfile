# 使用 debian bookworm-slim 版本（体积 ~30MB）
FROM debian:bookworm-slim

# 构建参数，构建时通过 --build-arg 传入）
ARG USER_NAME=""
ARG USER_NAME_CN=""
ARG USER_EMAIL=""
ARG HTTP_PROXY=""
ARG HTTPS_PROXY=""

# 环境变量
ENV DEBIAN_FRONTEND=noninteractive \
    LANG=C.UTF-8 \
    SHELL=/bin/bash \
    GO_VERSION=1.23.8 \
    GOPATH=/go \
    NEOVIM_VERSION=nightly \
    LAZYGIT_VERSION=0.61.0 \
    NVM_VERSION=0.40.3 \
    DEVELOPER_NAME=$USER_NAME \
    DEVELOPER_NAME_CN=$USER_NAME_CN \
    DEVELOPER_EMAIL=$USER_EMAIL

# 0. 在换源前先更新并安装 ca-certificates
RUN cp /etc/apt/sources.list.d/debian.sources /etc/apt/sources.list.d/debian.sources.bak && \
    echo "Types: deb" > /etc/apt/sources.list.d/debian.sources && \
    echo "URIs: http://mirrors.ustc.edu.cn/debian" >> /etc/apt/sources.list.d/debian.sources && \
    echo "Suites: bookworm bookworm-updates bookworm-backports" >> /etc/apt/sources.list.d/debian.sources && \
    echo "Components: main contrib non-free non-free-firmware" >> /etc/apt/sources.list.d/debian.sources && \
    echo "Signed-By: /usr/share/keyrings/debian-archive-keyring.gpg" >> /etc/apt/sources.list.d/debian.sources
RUN apt update && \
    apt install -y --no-install-recommends ca-certificates apt-transport-https

# 1. 换源（中科大镜像USTC）
RUN echo "Types: deb" > /etc/apt/sources.list.d/debian.sources && \
    echo "URIs: https://mirrors.ustc.edu.cn/debian" >> /etc/apt/sources.list.d/debian.sources && \
    echo "Suites: bookworm bookworm-updates bookworm-backports" >> /etc/apt/sources.list.d/debian.sources && \
    echo "Components: main contrib non-free non-free-firmware" >> /etc/apt/sources.list.d/debian.sources && \
    echo "Signed-By: /usr/share/keyrings/debian-archive-keyring.gpg" >> /etc/apt/sources.list.d/debian.sources

# 2. 如果有代理，配置代理
RUN if [ -n "$HTTP_PROXY" ]; then \
    echo "Acquire::http::Proxy \"$HTTP_PROXY\";" > /etc/apt/apt.conf.d/proxy.conf && \
    echo "Acquire::https::Proxy \"$HTTPS_PROXY\";" >> /etc/apt/apt.conf.d/proxy.conf; \
    fi

# 3. 安装开发环境基础依赖
RUN apt update && apt install -y --no-install-recommends \
    zsh \
    git \
    curl \
    wget \
    tar \
    iproute2 \
    iputils-ping \
    # rg命令，用于增强代码搜索功能
    ripgrep \
    # xlip所需相关依赖
    # xorg \
    # xclip \
    autojump \
    # ssh相关依赖
    openssh-client \
    # claude code相关依赖
    libstdc++6 \
    sudo \
    # 用于确保HTTPS源能正常验证
    ca-certificates && \
    # nodejs
    curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - && \
    apt install -y --no-install-recommends nodejs && \
    # 清理缓存
    rm -rf /var/lib/apt/lists/*

# 4. 安装 Go SDK
RUN wget -O /tmp/go.tar.gz "https://mirrors.aliyun.com/golang/go${GO_VERSION}.linux-amd64.tar.gz" && \
    tar -C /usr/local -xzf /tmp/go.tar.gz && \
    rm /tmp/go.tar.gz

# 5.安装 Neovim
RUN wget -O /tmp/nvim.tar.gz "https://ghfast.top/https://github.com/neovim/neovim/releases/download/${NEOVIM_VERSION}/nvim-linux-x86_64.tar.gz" && \
    # tar -C /usr/local --strip-components=1 -xzf /tmp/nvim.tar.gz && \
    tar -C /usr/local -xzf /tmp/nvim.tar.gz && \
    mv /usr/local/nvim-linux-x86_64 /usr/local/nvim && \
    rm /tmp/nvim.tar.gz

# 安装 Lazygit
RUN wget -O /tmp/lazygit.tar.gz "https://ghfast.top/https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_linux_x86_64.tar.gz" && \
    tar -C /tmp -xzf /tmp/lazygit.tar.gz && \
    mv /tmp/lazygit /usr/local/bin/lazygit && \
    rm /tmp/lazygit.tar.gz

# 6. 配置开发用户（避免使用 root）
RUN groupadd developer && \
    useradd -m -s /bin/bash -g developer ${DEVELOPER_NAME} && \
    echo "${DEVELOPER_NAME} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && \
    # 配置 Go 开发环境，使 /go 目录的所有者为 developer 组，且该目录下的文件自动继承组
    mkdir -p /go/pkg /go/dev && \
    chown -R ${DEVELOPER_NAME}:developer /go && \
    chmod -R 2775 /go
USER ${DEVELOPER_NAME}
WORKDIR /home/${DEVELOPER_NAME}

# 安装claude code（以开发用户权限安装，避免安装到/root路径下）
RUN echo "安装 Claude Code..." && \
    if [ -n "${HTTP_PROXY}" ]; then \
    echo "通过代理安装..." && \
    curl -fsSL --proxy "${HTTP_PROXY}" https://claude.ai/install.sh | bash; \
    else \
    echo "尝试直接安装..." && \
    # 尝试不同的源
    curl -fsSL https://claude.ai/install.sh 2>/dev/null | grep -q "#!/bin/bash" && \
    curl -fsSL https://claude.ai/install.sh | bash || \
    echo "Claude 安装脚本不可用，跳过安装"; \
    fi

# 安装claude-code-router
RUN sudo npm install -g @musistudio/claude-code-router && \
    sudo mkdir -p /home/${DEVELOPER_NAME}/.claude-code-router && \
    sudo chown -R ${DEVELOPER_NAME}:developer /home/${DEVELOPER_NAME}/.claude-code-router && \
    sudo chmod -R 755 /home/${DEVELOPER_NAME}/.claude-code-router

# 生成SSH密钥对
RUN mkdir -p ~/.ssh && chmod 700 ~/.ssh
# 创建智能初始化脚本
RUN cat > ~/.ssh/init-ssh.sh <<'EOF'
#!/bin/bash
# 智能 SSH 初始化脚本

SSH_DIR="$HOME/.ssh"
CONFIG_FILE="$SSH_DIR/config"
KNOWN_HOSTS="$SSH_DIR/known_hosts"

# 创建配置文件（如果不存在）
#if [ ! -f "$CONFIG_FILE" ]; then
#    cat > "$CONFIG_FILE" <<'CONFIG_EOF'
#Host *
#  AddKeysToAgent yes
#  UseKeychain yes
#  IdentityFile ~/.ssh/id_ed25519
#  IdentitiesOnly yes
#  ServerAliveInterval 60
#  ServerAliveCountMax 3
#  # GitHub
#  Host github.com
#    HostName github.com
#    User git
#  # GitLab
#  Host gitlab.com
#    HostName gitlab.com
#    User git
#CONFIG_EOF
#    chmod 600 "$CONFIG_FILE"
#fi

# 添加已知主机（如果不存在）
if [ ! -f "$KNOWN_HOSTS" ] || ! grep -q "github.com" "$KNOWN_HOSTS"; then
    ssh-keyscan github.com gitlab.com 2>/dev/null >> "$KNOWN_HOSTS" || true
    chmod 644 "$KNOWN_HOSTS"
fi

# 检查是否需要生成密钥
KEY_FILE="$SSH_DIR/id_ed25519"
if [ ! -f "$KEY_FILE" ]; then
    echo "⚠️  No SSH key found. Generating new one..."
    ssh-keygen -t ed25519 \
        -C "dev-container-$(hostname)-$(date +%Y%m%d)" \
        -f "$KEY_FILE" \
        -N ""
    chmod 600 "$KEY_FILE"

    echo ""
    echo "🔑 New SSH key generated!"
    echo "Public key:"
    cat "${KEY_FILE}.pub"
    echo ""
    echo "📋 To copy: cat ${KEY_FILE}.pub | xclip -sel clip"
    echo "🌐 Add to GitHub: https://github.com/settings/keys"
fi

# 启动 ssh-agent
eval "$(ssh-agent -s)" >/dev/null 2>&1
ssh-add "$KEY_FILE" 2>/dev/null || true
EOF

RUN chmod +x ~/.ssh/init-ssh.sh 

# 配置 Git
RUN git config --global user.name "${DEVELOPER_NAME}" && \
    git config --global user.email "${DEVELOPER_EMAIL}" && \
    # git config --global core.editor "nvim" && \
    git config --global init.defaultBranch "main" && \
    # 换行符处理
    git config --global core.autocrlf false && \
    git config --global core.eol lf && \
    git config --global core.safecrlf true && \
    # 提高大仓库性能
    git config --global feature.manyFiles true && \
    # 跳过Github SSL证书校验
    git config --global http.sslverify false && \
    git config --global https.sslverify false && \
    # HTTP/HTTPS 代理配置
    if [ -n "${HTTP_PROXY}" ]; then \
    git config --global http.proxy "${HTTP_PROXY}"; \
    fi && \
    if [ -n "${HTTPS_PROXY}" ]; then \
    git config --global https.proxy "${HTTPS_PROXY}"; \
    fi

# 配置 Irisvim & claude-code-router
RUN git clone --depth 1 https://ghfast.top/https://github.com/ukyang0623/dotfile.git /tmp/dotfile && \
    mv /tmp/dotfile/docker/dev/.config ~/ && \
    mv /tmp/dotfile/docker/dev/.claude-code-router/config.json ~/.claude-code-router/ && \
    rm -rf /tmp/dotfile

# 7. 安装 Oh My Zsh
RUN sh -c "$(curl -fsSLk https://ghfast.top/https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended && \
    # 安装常用插件（按需修改）
    git clone --depth 1 https://ghfast.top/https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions && \
    git clone --depth 1 https://ghfast.top/https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting && \
    git clone --depth 1 https://ghfast.top/https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions && \
    # 安装主题
    git clone --depth 1 https://ghfast.top/https://github.com/romkatv/powerlevel10k ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k && \
    cat > ~/.zshrc <<'EOF'
# 加载系统环境变量
setopt +o nomatch
if [ -f /etc/profile ]; then
    source /etc/profile
fi
source /etc/profile
# 加载 profile.d 目录下的脚本
if [ -d /etc/profile.d ]; then
    for file in /etc/profile.d/*.sh(N); do
        if [ -f "$file" ]; then
            source "$file"
        fi
    done
fi
# ~/.local/bin是cc相关的bin
export PATH="/home/${DEVELOPER_NAME}/.local/bin:/usr/local/nvim/bin:/usr/local/go/bin:/go/bin:$PATH"

# 启用 PowerLevel10k 主题
ZSH_THEME="powerlevel10k/powerlevel10k"

# Oh My Zsh 安装目录
export ZSH="$HOME/.oh-my-zsh"

# 插件列表
plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-completions
    autojump
    extract
    sudo
    web-search
)

# 加载 Oh My Zsh
source $ZSH/oh-my-zsh.sh

# 插件配置
# zsh-autosuggestions 配置
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#808080"
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# zsh-syntax-highlighting 配置（需在最后加载）
source ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# autojump 配置
if [ -f /usr/share/autojump/autojump.sh ]; then
    source /usr/share/autojump/autojump.sh
elif [ -f /usr/local/etc/profile.d/autojump.sh ]; then
    source /usr/local/etc/profile.d/autojump.sh
fi

# 自定义别名
alias zshconfig="vim ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"
alias srczsh="source ~/.zshrc"
alias ll="ls -alh"
alias nv="nvim"
alias lg="lazygit"

# 历史命令配置
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

# PowerLevel10k 即时提示（提升启动速度）
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# PowerLevel10k 配置文件
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

if [ -f ~/.ssh/init-ssh.sh ] && [ ! -f ~/.ssh/initialized ]; then
  ~/.ssh/init-ssh.sh
  touch ~/.ssh/initialized
fi
EOF

ENV SHELL=/bin/zsh

# 安装dotfile
#RUN rm -rf ~/dotfile && \
#    git clone --depth 1 https://ghfast.top/https://github.com/ukyang0623/dotfile.git ~/dotfile

# 8. 复制你的 dotfiles（假设你有本地配置文件）
# COPY --chown=developer:developer .config /home/developer/.config

# 9. 切换用户
# USER ${DEVELOPER_NAME}
# WORKDIR /home/${DEVELOPER_NAME}

# 11. 设置默认启动命令
# ENTRYPOINT ["/tmp/init-ssh.sh"]
CMD ["tail", "-f", "/dev/null"]
