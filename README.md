# Chezmoi Dotfiles Project

## Project Overview
This is a dotfiles repository managed by `chezmoi`. It handles system configurations, dotfiles, and automated setups for developer environments. It utilizes a combination of `bash` scripts, `Homebrew` (via Linuxbrew), and `Ansible` to bootstrap the environment, installing essential tools like Neovim, Nushell, Starship, Wezterm, k3s, and FluxCD.

## Key Files & Directories

- **`run_bootstrap.sh`**: The primary entry point for bootstrapping the system. It installs Linuxbrew and Ansible, and then executes the setup playbook.
- **`ansible/setup.yml`**: An Ansible playbook responsible for installing necessary packages using `homebrew` and bootstrapping a `k3s` cluster when the target hostname is 'dell'.
- **`.chezmoi.toml.tmpl`**: The Chezmoi configuration template. It enables automatic Git commits and pushes for dotfile changes.
- **`dot_config/`**: Contains configurations for various tools managed by Chezmoi:
  - **`nushell/`**: Nushell environment and configuration files (`config.nu`, `env.nu`).
  - **`starship.toml`**: Starship prompt configuration.
  - **`nvim/`**: A full Neovim configuration built on the [LazyVim](https://github.com/LazyVim/LazyVim) starter template.
- **`dot_wezterm.lua`**: Configuration for the Wezterm terminal emulator.

## Building and Running (Usage)

This repository is intended to be used directly with `chezmoi`.

1.  **Bootstrapping a new machine:**
    You can initialize and apply the dotfiles, which will trigger `run_bootstrap.sh` (due to Chezmoi run scripts conventions if named `run_`):
    ```bash
    chezmoi init --apply <your-repo-url>
    ```
    Or run the bootstrap script directly to install prerequisites and execute the Ansible setup playbook:
    ```bash
    ./run_bootstrap.sh
    ```

2.  **Updating Dotfiles:**
    When adding or modifying configurations in the local `~/.local/share/chezmoi` directory, Chezmoi is configured (via `.chezmoi.toml.tmpl`) to automatically commit and push changes.

3.  **Applying Changes:**
    ```bash
    chezmoi apply
    ```

## Development Conventions
- **Idempotency:** The Ansible playbook (`ansible/setup.yml`) and bootstrap script are written to be idempotent. They check for existing installations (like `k3s` and `brew`) before attempting to install them.
- **Lazy Loading Plugins:** The Neovim setup follows LazyVim's structure, loading plugins asynchronously for fast startup times.
- **Git Automation:** Updates to these dotfiles are set to automatically commit and push to the remote repository.
