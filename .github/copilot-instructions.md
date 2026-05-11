# Copilot Instructions for `dotfiles`

## Build, test, and lint commands

This repository has no repo-level automated test or lint suite (no `npm`, `cargo`, `pytest`, etc. project config at root). The actionable build commands are for the vendored suckless tools:

```bash
# Build one tool
cd suckless/.config/suckless/<tool> && make

# Clean + install one tool (pattern used in README)
cd suckless/.config/suckless/<tool> && sudo make clean install
```

`<tool>` is one of: `dwm`, `dmenu`, `st`, `slstatus`.

Single-test command: not available in this repository (no automated test harness is defined).

## High-level architecture

This is a cross-platform dotfiles monorepo organized by target application, with configs committed in-place and then linked into `$HOME`/`%USERPROFILE%`.

1. **Linking layer**
   - `symlink.sh` creates Unix symlinks from repo paths into home config locations.
   - `link.ps1` is the Windows equivalent and intentionally uses:
     - junctions for directories (no admin needed),
     - symbolic links for files,
     - destination replacement (`Remove-Item -Recurse -Force`) before relinking.

2. **Neovim configuration (`nvim/.config/nvim`)**
   - `init.lua` bootstraps `lusedou` core and lazy.nvim.
   - `lua/lusedou/` contains base editor behavior (options, keymaps, autocommands, plugin bootstrap).
   - `lua/custom/plugins/init.lua` is the plugin entrypoint and delegates to many `custom.plugins.*` modules.
   - Plugin modules are domain-scoped (LSP, formatting, testing, language-specific tooling, git, UI, etc.) rather than one monolithic plugin file.

3. **Suckless workspace (`suckless/.config/suckless`)**
   - Includes full source trees for `dwm`, `dmenu`, `st`, and `slstatus`.
   - Each tool is compiled from its local `Makefile`.
   - `run.sh` is the X session startup script: loads Xresources, wallpaper, compositor, then starts `slstatus` and `dwm`.

## Key conventions in this codebase

1. **Keep config paths “as deployed” inside the repo**
   - App directories mirror final locations (for example `nvim/.config/nvim/...`, `starship/.config/starship.toml`), so linking scripts can stay simple.

2. **Neovim module split: `lusedou` core vs `custom.plugins`**
   - Core behavior belongs in `lua/lusedou/*`.
   - Plugin specs/integration belong in `lua/custom/plugins/*`.
   - New plugin integrations should be added as imported modules in `lua/custom/plugins/init.lua`.

3. **Neovim editing defaults are opinionated and global**
   - `<Space>` is the leader key.
   - Trailing whitespace is trimmed on `BufWritePre` for all buffers.
   - Formatting is unified through conform.nvim mappings/config (`<leader>f`) and tool installation via mason-tool-installer.

4. **Suckless build workflow follows upstream patterns**
   - `config.h` is generated from `config.def.h` by Makefiles when missing.
   - Standard targets are expected (`all`, `clean`, `install`, `uninstall`, `dist`); prefer those instead of custom build wrappers.
