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

## plugins

- `null-ls.nvim` 是一个专为 Neovim 设计的插件，提供了一种优雅的方式来运行各种语言的静态代码分析工具，并将结果实时地显示在缓冲区内。
- `mason.nvim` 是一个 Neovim 插件管理器，专注于提供一个简单、一致的接口来管理外部工具和语言服务器。
- `nvim-lspconfig` 是一个 Neovim 插件，用于配置和管理 LSP（Language Server Protocol）客户端，
与 `mason-null-ls.num` 一起使用，可以提供更强大的代码编辑体验。
- `Gruvbox.nvim`，一个基于 Gruvbox 社区主题的 Neovim 配色方案，使用 Lua 编写，支持 Treesitter 和语义高亮.
- `Yanky.nvim` 是一个专为 Neovim 打造的高效插件，旨在提供便捷的复制粘贴功能，增强文本操作体验。
- `lualine.nvim`
- `which-key.nvim`
- File explorer: `nvim-tree/nvim-web-devicons`, `nvim-tree/nvim-tree.lua`, `christoomey/vim-tmux-navigator`
- Treesitter:
    `nvim-treesitter/nvim-treesitter`
    `p00f/nvim-ts-rainbow`,
    `nvim-treesitter/nvim-treesitter-textobjects`,
    `nvim-treesitter/nvim-treesitter-context`,
    `windwp/nvim-ts-autotag`,
    `JoosepAlviste/nvim-ts-context-commentstring`,
    `andymass/vim-matchup`,
    `mfussenegger/nvim-treehopper`
- Surround:
    `kylechui/nvim-surround`
- Autopairs:
    `windwp/nvim-autopairs`
- Git integration:
    `tpope/vim-fugitive`
- indentation and blankline:
    `lukas-reineke/indent-blankline.nvim`
- Git integration:
    `tpope/vim-fugitive`, `lewis6991/gitsigns.nvim`
- Code comment helper:
    `tpope/vim-commentary`
- Buffer line:
    `akinsho/bufferline.nvim`, `famiu/bufdelete.nvim`
- TODO comments
    `folke/todo-comments.nvim`
- Telescope:
    `nvim-telescope/telescope.nvim`
- Smart motion:
    `smoka7/hop.nvim`
- Markdown:
    `preservim/vim-markdown`,
    `mzlogin/vim-markdown-toc`,
    `iamcco/markdown-preview.nvim`
- LSP syntax diagnostics:
    `neovim/nvim-lspconfig`, `williamboman/mason.nvim`,
    `williamboman/mason-lspconfig.nvim`, `mason-org/mason-registry`,
    `onsails/lspkind.nvim`
- Auto-completion engine:
    `hrsh7th/nvim-cmp`, `onsails/lspkind-nvim`, `hrsh7th/cmp-nvim-lsp`,
    `hrsh7th/cmp-nvim-lsp-signature-help`, `hrsh7th/cmp-buffer`, `hrsh7th/cmp-path`,
    `hrsh7th/cmp-cmdline`, `f3fora/cmp-spell`, `hrsh7th/cmp-calc` `hrsh7th/cmp-emoji`,
    `chrisgrieser/cmp_yanky`, `lukas-reineke/cmp-rg`, `lukas-reineke/cmp-under-comparator`
- Code snippet engine:
    `L3MON4D3/LuaSnip`, `saadparwaiz1/cmp_luasnip`
- Autopairs:
    `windwp/nvim-autopairs`
- Linter && Formatter
    `jay-babu/mason-null-ls.nvim`, `jose-elias-alvarez/null-ls.nvim`,
    `nvimtools/none-ls.nvim`
- Trouble: `folke/trouble.nvim'`
- LSP Signature:
    `ray-x/lsp_signature.nvim`
