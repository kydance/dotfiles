# dotfiles

dotfiles are how you personalize system.

## VSCode

### Create Soft Link

```bash
# Input method
$ brew tap daipeihust/tap
$ brew install im-select

# Verify
$ im-select
com.apple.keylayout.ABC

$ git clone git@github.com:kydance/dotfiles.git ~/.dotfiles

# Mac
$ ln -s ~/.dotfiles/vscode/keybindings.json /Users/<YourUserName>/Library/Application\ Support/Code/User/keybindings.json
$ ln -s ~/.dotfiles/vscode/settings.json /Users/<YourUserName>/Library/Application\ Support/Code/User/settings.json
```

---

## Neovim (Nvim)

## Install neovim

```bash
# xsel: 为了解决共用系统剪切板的问题
sudo pacman -S neovim xsel
```

## 版本信息

```bash
$ nvim --version
NVIM v0.9.2
Build type: Release
LuaJIT 2.1.1694285958

   system vimrc file: "$VIM/sysinit.vim"
  fall-back for $VIM: "/usr/share/nvim"

Run :checkhealth for more info
```

## 使用方式

```bash
$ cd ~
$ git clone https://github.com/kydance/nvim.git
$ ln -s ~/.dotfiles/nvim/ ~/.config/nvim

$ Verify
$ ls -l ~/.config
# ...
lrwxr-xr-x@ 1 kyden  staff    27B 23 Sep 22:55 nvim -> /Users/kyden/.dotfiles/nvim
# ...
```

### 常用命令

#### 段落移动

在程序开发时，通常一段功能相关的代码会写在一起，即之间没有空行，这时可以用段落移动命令来快速移动光标。

> `{`   # 移动到上一段的开头
>
> `}`   # 移动到下一段的开头

#### 括号切换

> `%`: 括号匹配以及切换

#### 单词快速匹配

> `#`: 匹配光标所在单词，向前查找（快速查看这个单词在其他什么位置使用过）

#### 文件操作

> `:e`：edit，会打开内置的文件浏览器，浏览当下目录的文件
>
> `:n filename`：new，新建文件
>
> `:w filename`：write，保存文件

#### 分屏

> `:sp[filename]`：split，水平分屏
>
> `:vsp[filename]`：vertical split，垂直分屏

---
