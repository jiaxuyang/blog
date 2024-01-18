---
title: "git"
date: 2020-09-21T15:08:17+08:00
draft: false
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
## Basis
以下命令展示了一个完整的创建分支并提交改动的使用场景。
```bash
# 从当前本地repo创建新的本地分支 feature/foo，会保留当前所有已提交未提交的改动。
git checkout -b feature/foo
# 添加所有改动到 commit stage.
git add .
# 提交改动。会自动打开默认编辑器来编辑 commit message.
git commit
# [可选]添加新的 remote。默认的remote是origin，如果需要提交到其它repo，需要新建remote.
git remote add jiaxuyang https://github.com/jiaxuyang/blog.git
# 推送改动到git服务器。
git push --set-upstream origin feature/foo
git push --set-upstream jiaxuyang feature/foo
```
以下命令展示从远程分支合并到本地分支。
```bash
# 获取 remote 最新状态
git fetch
# 或者
git pull
# 合并到本地，一定要加 remote 名称前缀，否则会从本地分支合并。
git merge origin/dev
# 如果有冲突，可以用 vscode 或 jetbrains 等 IDE 可视化解决，解决后 commit.
git add .
git commit
# 如果没有冲突或者冲突已经解决，push即可
git push
```
## Submodule
1. git clone 拉取 submodules
   ```
   git clone --recurse-submodules -j8 git://github.com/foo/bar.git
   ```
   1. git 版本 >= 2.13
   2. `-j8`作用是性能优化，获取submodule的并行度最大为8。2.8版本加入。see `man git-clone`
2. git pull 拉取 submodules
   如果已经执行过`git clone`后发现缺少submodules，使用以下命令：
   `git submodule update --init` 或 `git submodule update --init --recursive`
## Commit 规范
  - 使用空行将提交记录的标题和正文分开
  - 限制标题字符数在 50 以内
  - 标题首字母大写
  - 标题行末不使用句号
  - 在标题中使用祈使句
  - 限制单行字符长度最大为 72
  - 在正文中详细解释说明这次提交的改动
## macOS
1. install
   > xcrun: error: invalid active developer path (/Library/Developer/CommandLineTools), missing xcrun at: /Library/Developer/CommandLineTools/usr/bin/xcrun
   
   报以上错误时需要安装 git：`xcode-select --install`
## Commit Amend
如果已经commit之后发现用户名或邮箱不对，可以使用 amend 选项来修改：
```bash
git commit --amend --author="jiaxuyang <xy.jia@aliyun.com>"
```
