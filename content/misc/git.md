---
title: "Git"
date: 2020-09-21T15:08:17+08:00
draft: true
---

# Git
## Account
1. 设置项目级别账户
   ```
   git config user.name "jiaxuyang"
   git config user.email "xy.jia@aliyun.com"
   ```
2. 记住密码
   ```
   git config --global credential.helper store
   ```
   设了这条命令后下次输入的credentials会被存储下来
## Submodule
1. git clone 拉取 submodules
   ```
   git clone --recurse-submodules -j8 git://github.com/foo/bar.git
   ```
   1. git 版本 >= 2.13
   2. `-j8`作用是性能优化，获取submodule的并行度最大为8。2.8版本加入。see `man git-clone`
2. git pull 拉取 submodules
   如果已经执行过`git clone`后发现缺少submodules，使用以下命令：
   `git submodule update --init`
