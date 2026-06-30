# Neovim Config

Personal Neovim configuration managed by `lazy.nvim`.

## What This Config Provides

- Plugin management with `lazy.nvim`
- LSP setup through `nvim-lspconfig`, `mason.nvim`, and `mason-lspconfig.nvim`
- Completion through `blink.cmp`
- Formatting through `conform.nvim`
- Lint integration through `nvim-lint`
- Treesitter highlighting, indentation, folds, and textobjects
- File/search UI through `snacks.nvim` and `neo-tree.nvim`
- Git signs through `gitsigns.nvim`
- UI plugins such as `gruvbox.nvim`, `lualine.nvim`, `bufferline.nvim`, and `which-key.nvim`

## Requirements

Install these on a new server before starting Neovim:

```sh
git
nvim
ripgrep
curl or wget
unzip
tar
gzip
make
gcc or clang
```

Recommended versions:

- Neovim 0.11 or newer
- Git with access to GitHub or your configured plugin mirror

`ripgrep` is important because this config sets `grepprg` to `rg --vimgrep`.

## Install On A New Server

Back up any existing Neovim config first:

```sh
mv ~/.config/nvim ~/.config/nvim.bak
```

Clone this repository:

```sh
git clone <repo-url> ~/.config/nvim
```

Start Neovim:

```sh
nvim
```

On first launch, `lua/config/lazy.lua` bootstraps `lazy.nvim` into Neovim's data directory and then installs plugins from `lazy-lock.json`.

If plugin installation does not start automatically, run:

```vim
:Lazy sync
```

Then restart Neovim.

## Language Servers And Tools

This config defines these LSP servers:

- `lua_ls`
- `eslint`
- `vtsls`
- `vue_ls`

They are registered in `lua/plugins/lspconfig.lua` and passed to `mason-lspconfig` for installation.

After plugins are installed, run:

```vim
:Mason
```

Confirm the required LSP packages are installed. If any are missing, install them from the Mason UI.

The formatter config currently references:

- `stylua` for Lua
- `fish_indent` for Fish
- `shfmt` for shell scripts

If formatting does not work for one of these filetypes, install the missing tool through Mason or your system package manager.

## External Dependencies To Watch

This config is portable, but a fresh server still needs a few external pieces:

- GitHub or plugin mirror access for `lazy.nvim` and plugin downloads
- Network access for Mason package downloads
- `git` for plugin bootstrap and Git-related UI
- `ripgrep` for grep/search commands
- A C compiler and archive tools for plugins or Treesitter parsers that need local builds
- Nerd Font support if you want icons to render correctly

The config avoids hard-coded local user paths. Runtime paths are based on Neovim standard paths such as `stdpath('data')`.

## Server Or SSH Notes

Clipboard is disabled automatically over SSH:

```lua
vim.env.SSH_CONNECTION and '' or 'unnamedplus'
```

This avoids assuming the remote server has a desktop clipboard provider.

Some UI features, such as opening a file through `vim.ui.open`, depend on the server environment. They are not required for normal editing.

## Health Check

After installation, run:

```vim
:checkhealth
:Lazy
:Mason
:LspInfo
:ConformInfo
```

Useful checks:

- `:Lazy` should show all plugins installed.
- `:Mason` should show required LSP servers installed.
- `:LspInfo` should show an attached server when opening a supported project file.
- `:ConformInfo` should show available formatters for the current filetype.

## Updating

Update plugins:

```vim
:Lazy update
```

After confirming everything works, commit the updated lockfile:

```sh
git add lazy-lock.json
git commit -m "chore: update nvim plugins"
```

## Before Pushing This Config

Make sure all config files are tracked:

```sh
git status --short
```

Important files and directories:

```sh
init.lua
lazy-lock.json
lua/config/
lua/plugins/
lua/vscode-conf.lua
.luarc.json
.gitignore
README.md
```

If new config files are untracked, add them before pushing:

```sh
git add init.lua lazy-lock.json lua/config lua/plugins lua/vscode-conf.lua .luarc.json .gitignore README.md
git add -u
```

## Troubleshooting

If `lazy.nvim` fails to bootstrap:

- Check that `git` is installed.
- Check that the server can access GitHub or your plugin mirror.
- Run `nvim` again after fixing network access.

If plugins fail to install:

```vim
:Lazy sync
```

If LSP does not attach:

```vim
:Mason
:LspInfo
```

Install the missing server from Mason and reopen the file.

If search commands fail:

```sh
rg --version
```

Install `ripgrep` if the command is missing.

If icons look wrong, install and use a Nerd Font in your terminal.
