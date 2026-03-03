#!/bin/bash

# 脚本功能：安装并配置 zsh + oh-my-zsh + zsh-autosuggestions
# 支持系统：Ubuntu / macOS
# 作者：OpenClaw Assistant
# 日期：2026-03-03
# 使用说明：直接运行 ./setup_zsh.sh，脚本会在需要时自动请求 sudo 权限

# 检测操作系统类型
detect_os() {
  if [ "$(uname)" = "Darwin" ]; then
    echo "macOS"
  elif [ -f "/etc/os-release" ]; then
    if grep -q "Ubuntu" "/etc/os-release"; then
      echo "Ubuntu"
    else
      echo "Unknown Linux distribution"
      exit 1
    fi
  else
    echo "Unknown operating system"
    exit 1
  fi
}

OS=$(detect_os)
echo "当前操作系统：$OS"

# 获取当前用户信息
CURRENT_USER=$(whoami)
echo "当前用户：$CURRENT_USER"

# 检查 zsh 是否已安装
check_zsh_installed() {
  if command -v zsh &> /dev/null; then
    echo "zsh 已安装（版本：$(zsh --version)）"
    return 0
  else
    return 1
  fi
}

# 安装 zsh（根据操作系统）
install_zsh() {
  if check_zsh_installed; then
    return 0
  fi

  echo "开始安装 zsh..."
  if [ "$OS" = "Ubuntu" ]; then
    sudo apt-get update -y
    sudo apt-get install -y zsh
  elif [ "$OS" = "macOS" ]; then
    # 检查 Homebrew 是否安装
    if ! command -v brew &> /dev/null; then
      echo "正在安装 Homebrew..."
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    brew install zsh
  fi

  if check_zsh_installed; then
    echo "zsh 安装成功"
  else
    echo "zsh 安装失败"
    exit 1
  fi
}

# 设置默认 shell 为 zsh
set_default_shell() {
  # 检查当前默认 shell 是否已经是 zsh
  if [ "$(echo $SHELL)" = "/bin/zsh" ] || [ "$(echo $SHELL)" = "/usr/bin/zsh" ]; then
    echo "当前默认 shell 已经是 zsh，无需修改"
    return 0
  fi

  echo "设置默认 shell 为 zsh..."
  if [ "$OS" = "Ubuntu" ]; then
    sudo chsh -s /usr/bin/zsh "$CURRENT_USER"
  elif [ "$OS" = "macOS" ]; then
    # macOS 需要使用 dscl 命令
    sudo dscl . -change /Users/"$CURRENT_USER" UserShell "$(dscl . -read /Users/"$CURRENT_USER" UserShell | awk '{print $2}')" /bin/zsh
  fi

  echo "默认 shell 已更改为 zsh"
}

# 安装 oh-my-zsh
install_ohmyzsh() {
  if [ -d "$HOME/.oh-my-zsh" ]; then
    echo "oh-my-zsh 已安装"
    return 0
  fi

  echo "安装 oh-my-zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  if [ $? -eq 0 ]; then
    echo "oh-my-zsh 安装成功"
  else
    echo "oh-my-zsh 安装失败"
    exit 1
  fi
}

# 安装 zsh-autosuggestions 插件
install_zsh_autosuggestions() {
  ZSH_CUSTOM=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}
  PLUGIN_PATH="$ZSH_CUSTOM/plugins/zsh-autosuggestions"

  if [ -d "$PLUGIN_PATH" ]; then
    echo "zsh-autosuggestions 插件已安装"
    return 0
  fi

  echo "安装 zsh-autosuggestions 插件..."
  git clone https://github.com/zsh-users/zsh-autosuggestions "$PLUGIN_PATH"
  if [ $? -eq 0 ]; then
    echo "zsh-autosuggestions 插件安装成功"
  else
    echo "zsh-autosuggestions 插件安装失败"
    exit 1
  fi
}

# 配置 oh-my-zsh（禁用自动更新、启用插件等）
configure_ohmyzsh() {
  ZSHRC="$HOME/.zshrc"

  # 备份原始配置文件
  if [ ! -f "$ZSHRC.backup" ] && [ -f "$ZSHRC" ]; then
    cp "$ZSHRC" "$ZSHRC.backup"
    echo "已备份原始配置文件到 $ZSHRC.backup"
  fi

  # 禁用 oh-my-zsh 自动更新
  echo "禁用 oh-my-zsh 自动更新..."
  if grep -q "DISABLE_AUTO_UPDATE" "$ZSHRC"; then
    sed -i "s/^#* DISABLE_AUTO_UPDATE=.*/DISABLE_AUTO_UPDATE=\"true\"/" "$ZSHRC"
  else
    echo 'DISABLE_AUTO_UPDATE="true"' >> "$ZSHRC"
  fi

  # 启用 zsh-autosuggestions 插件
  echo "启用 zsh-autosuggestions 插件..."
  if grep -q "plugins=(" "$ZSHRC"; then
    if ! grep -q "zsh-autosuggestions" "$ZSHRC"; then
      sed -i "s/plugins=(\(.*\))/plugins=(\1 zsh-autosuggestions)/" "$ZSHRC"
    fi
  else
    echo 'plugins=(git zsh-autosuggestions)' >> "$ZSHRC"
  fi

  echo "oh-my-zsh 配置完成"
}

# 主执行函数
main() {
  echo "=================================="
  echo "开始配置 zsh 开发环境"
  echo "=================================="

  # 1. 安装 zsh（如果尚未安装）
  install_zsh

  # 2. 设置默认 shell
  set_default_shell

  # 3. 安装 oh-my-zsh（如果尚未安装）
  install_ohmyzsh

  # 4. 安装 zsh-autosuggestions 插件
  install_zsh_autosuggestions

  # 5. 配置 oh-my-zsh
  configure_ohmyzsh

  echo "=================================="
  echo "✅ zsh 配置已完成！"
  echo "=================================="
  echo ""
  echo "请重新登录或运行 'exec zsh' 生效配置"
  echo ""
  echo "配置说明："
  echo "- 默认 shell：zsh"
  echo "- 框架：oh-my-zsh（已禁用自动更新）"
  echo "- 插件：zsh-autosuggestions（已启用）"
}

# 执行主函数
main
