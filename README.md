# Neovim 代码查看器配置

这是一套侧重代码浏览、搜索和阅读的轻量 Neovim 配置。独立 Neovim 不提供 LSP、补全、诊断、lint、自动格式化或 Git 变更追踪；需要跨文件开发时使用完整 IDE。

## 核心能力

- `snacks.nvim`：文件查找、全文搜索和 buffer 切换
- `neo-tree.nvim`：目录结构浏览
- Treesitter：语法高亮、代码折叠及函数/类结构跳转
- `flash.nvim`：当前页面快速跳转
- `mini.comment`、`mini.surround`：少量编辑辅助
- `gruvbox.nvim`、精简版 `lualine.nvim`：基础界面
- VSCode Neovim：保留基础兼容配置

## 配置结构

```text
init.lua                 加载入口
lua/config/options.lua   Neovim 基础选项
lua/config/autocmds.lua  文件与界面事件
lua/config/keymaps.lua   通用快捷键
lua/config/lazy.lua      插件管理器入口
lua/plugins/             按插件拆分的功能配置
lua/vscode-conf.lua      VSCode Neovim 专用快捷键
```

## 快捷键速查

| 快捷键 | 功能 |
| --- | --- |
| `<leader>e` | 打开项目根目录文件树 |
| `<leader>E` | 打开当前工作目录文件树 |
| `<leader><space>` / `<leader>ff` | 从项目根目录找文件 |
| `<leader>fF` | 从当前工作目录找文件 |
| `<leader>sg` | 在项目根目录全文搜索 |
| `<leader>sG` | 在当前工作目录全文搜索 |
| `<leader>sw` | 搜索光标下单词或选中文本 |
| `<leader>,` | 切换 buffer |
| `s` | Flash 页面内跳转 |
| `]f` / `[f` | 下一个 / 上一个函数开头 |
| `]c` / `[c` | 下一个 / 上一个类开头 |
| `za` / `zM` / `zR` | 切换 / 全部关闭 / 全部打开折叠 |
| `gcc` / `gc` | 注释行 / 选区 |
| `gsa` / `gsd` / `gsr` | 添加 / 删除 / 替换 surround |

`<leader>` 是空格。搜索和文件树默认以最近的 Git 根目录为范围，大写快捷键版本使用当前工作目录。

## 基础依赖

- Neovim 0.11 或更新版本
- Git
- ripgrep
- curl 或 wget
- Treesitter parser 构建所需的编译器及常见压缩工具
- 可选：支持图标的 Nerd Font

## 安装

```sh
git clone <repo-url> ~/.config/nvim
nvim
```

首次启动会安装 `lazy.nvim` 及配置中的插件。安装没有自动开始时执行：

```vim
:Lazy sync
```

打开目录时，`nvim some-directory` 会进入 Neo-tree；直接打开文件时只显示该文件。

## 使用说明

- 配置不会隐式保存文件，只在执行 `:w` 或 `⌘S` 时保存。
- 持久撤销已启用，可使用原生 `u` 和 `<C-r>` 撤销、重做。
- SSH 环境会关闭系统剪贴板，避免依赖远端桌面 clipboard provider。
- VSCode Neovim 继续使用 `lua/vscode-conf.lua`，并复用阅读与轻编辑插件。

## 检查与更新

```vim
:checkhealth
:Lazy
:Lazy update
```

如果文件或全文搜索失败，先确认 `rg --version` 可用。如果图标显示异常，请启用 Nerd Font。
