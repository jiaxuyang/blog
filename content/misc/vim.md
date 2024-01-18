---
title: "vim"
date: 2020-10-03T20:54:11+08:00
---

# Vim
## NeoVim
1. 安装
   ```bash
   brew install neovim
   ```
2. 替代vim命令
   ```bash
   alias vim=nvim
   ```
3. 配置
   1. 默认的配置路径是 `~/.config/nvim/init.vim`
   2. 下面是一份我在使用的 neovim 配置：
      ```vimrc
      """""""""""""""""""""""""""""""""""""""""
      " provide hjkl movements in Insert mode
      " provide hjkl movements in ex mode
      """""""""""""""""""""""""""""""""""
      noremap! <C-a> <Home>
      inoremap <C-e> <End>
      inoremap <A-BS> <C-\><C-o>db
      noremap! <C-f>  <Right>
      "cnoremap <A-f> <C-f>
      cnoremap ƒ <C-f>
      noremap! <C-b>  <Left>
      inoremap <C-d> <DEL>
      inoremap <C-k>  <C-o>D
      nnoremap <C-k>  D
      "nnoremap <D-a> a

      """"""""""""""""""
      " config iTerm2 keys: Esc+Ac, Esc+As, Esc+Aa
      " close & write & clipboard copy paste
      """""""""""""""""""""
      " Quit
      nnoremap <C-q> :qa<CR>
      " Copy
      vnoremap <M-A>c "+y
      " Save
      nnoremap <M-A>s :up<CR>
      inoremap <M-A>s <C-o>:up<CR>
      " Select whole content
      nnoremap <M-A>a ggVG
      " Paste
      nnoremap \p "+p

      "open
      :au BufReadPost *
         \ if line("'\"") > 1 && line("'\"") <= line("$") && &ft !~# 'commit' 
         \ |   exe "normal! g`\""
         \ | endif
      ```
## 列编辑
  - Ctrl + v column mode edit command.
  - Select the columns, rows (h,j,k,l)
  - Shift + i to go into insert mode in column mode.
  - Type in desired text. At the time of typing only ONE row is changed, showed.
  - Press the Esc key to apply the changes to the selected column.
## sudo 保存
```vimrc
" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %
```
## 其它
```
gb adds another cursor on the next word it finds which is the same as the word under the cursor. Like * but instead of jumping to next ocurrence it creates multiple cursors.
af is a visual moe command that selects increasingly larger blocks of text.
gh is the equivalent of hovering the mouse over where the cursor is. Super handy in order to enable a keyboard only workflow and still enjoy some features (error messages, types, etc) only available via the mouse.
/ ? 包含查找
* # 精确查找
g* g# 包含查找
/ 重复之前的查找
```
## 替换
```
:%s/ +/<Ctrl-V><Enter>/g 替换全文的空格为换行
拆分解释：
% 代表全文
s 代表substitute
替换str中的换行不能用 \n, 应该用<CR>（按键：<Ctrl-V><Enter>)，因为\n代表了<NUL>字符
g 代表全局匹配
```