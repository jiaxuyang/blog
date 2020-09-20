---
title: "shell config"
date: 2020-09-20T21:18:39+08:00
---
# Mac
- Zsh
  1. 查看已安装的shells：cat /etc/shells
  2. 安装zsh：brew install zsh
  3. 设置默认shell：chsh -s /bin/zsh
- iterm2
- oh-my-zsh
  1. zsh-syntax-highlighting
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
  2. autojump
  brew install autojump
  j --purge
  3. zsh-autosuggestions
  git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
# Ubuntu
- Zsh
  1. 查看已安装的shells：cat /etc/shells
  2. 安装zsh：brew install zsh
  3. 设置默认shell：chsh -s /bin/zsh
- oh-my-zsh
  1. zsh-syntax-highlighting
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
  2. autojump
  brew install autojump
  j --purge
  3. zsh-autosuggestions
  git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions