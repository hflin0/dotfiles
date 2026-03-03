#!/bin/bash

# 脚本功能：安装并配置 zsh + oh-my-zsh + zsh-autosuggestions
# 作者：OpenClaw Assistant
# 日期：2026-03-03

# 检查是否以 root 权限运行

# 更新软件源并安装 zsh
echo "1. 更新软件源并安装 zsh..."
sudo apt-get update -y
sudo apt-get install -y zsh

# 检查 zsh 是否安装成功
if ! command -v zsh &> /dev/null; then
  echo "zsh 安装失败，请检查网络连接或权限"
  exit 1
fi

# 为当前用户设置默认 shell 为 zsh
echo "2. 设置默认 shell 为 zsh..."
CURRENT_USER=$(logname 2>/dev/null || echo "$SUDO_USER")
if [ -z "$CURRENT_USER" ]; then
  echo "无法获取当前用户信息"
  exit 1
fi

sudo chsh -s /usr/bin/zsh "$CURRENT_USER"
echo "默认 shell 已成功更改为 zsh"

# 切换到当前用户并安装 oh-my-zsh
echo "3. 安装 oh-my-zsh..."

  # 检查 oh-my-zsh 是否已安装
  if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    if [ $? -eq 0 ]; then
      echo "oh-my-zsh 安装成功"
    else
      echo "oh-my-zsh 安装失败"
      exit 1
    fi
  else
    echo "oh-my-zsh 已安装，跳过此步骤"
  fi


# 安装 zsh-autosuggestions 插件
echo "4. 安装 zsh-autosuggestions 插件..."
  ZSH_CUSTOM=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}
  PLUGIN_PATH="$ZSH_CUSTOM/plugins/zsh-autosuggestions"
  
  if [ ! -d "$PLUGIN_PATH" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions "$PLUGIN_PATH"
    if [ $? -eq 0 ]; then
      echo "zsh-autosuggestions 插件安装成功"
    else
      echo "zsh-autosuggestions 插件安装失败"
      exit 1
    fi
  else
    echo "zsh-autosuggestions 插件已安装，跳过此步骤"
  fi

# 配置 oh-my-zsh（禁用自动更新、启用插件等）
echo "5. 配置 oh-my-zsh..."
  # 备份原始配置文件
  if [ ! -f "$HOME/.zshrc.backup" ] && [ -f "$HOME/.zshrc" ]; then
    cp "$HOME/.zshrc" "$HOME/.zshrc.backup"
    echo "已备份原始配置文件到 $HOME/.zshrc.backup"
  fi

  # 禁用 oh-my-zsh 自动更新
  sed -i "s/^# DISABLE_AUTO_UPDATE=\"true\"/DISABLE_AUTO_UPDATE=\"true\"/" "$HOME/.zshrc"
  if ! grep -q "DISABLE_AUTO_UPDATE" "$HOME/.zshrc"; then
    echo 'DISABLE_AUTO_UPDATE="true"' >> "$HOME/.zshrc"
  fi

  # 启用 zsh-autosuggestions 插件
  if grep -q "plugins=(" "$HOME/.zshrc"; then
    # 检查是否已包含 zsh-autosuggestions
    if ! grep -q "zsh-autosuggestions" "$HOME/.zshrc"; then
      sed -i "s/plugins=(\(.*\))/plugins=(\1 zsh-autosuggestions)/" "$HOME/.zshrc"
    fi
  else
    echo 'plugins=(git zsh-autosuggestions)' >> "$HOME/.zshrc"
  fi

  echo "oh-my-zsh 配置完成"

echo "=================================="
echo "✅ zsh 配置已完成！"
echo "=================================="
echo ""
echo "请重新登录或运行 'exec zsh' 生效配置"
echo ""
echo "配置说明："
echo "- 默认 shell 已更改为 zsh"
echo "- 已安装 oh-my-zsh（禁用自动更新）"
echo "- 已安装 zsh-autosuggestions 插件"
echo "- 插件已启用在 .zshrc 中"
