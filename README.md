# Chezmoi Dotfiles Project

## Project Overview
This is a dotfiles repository managed by `chezmoi`. It handles system configurations, dotfiles, and automated setups for developer environments. It utilizes a combination of `bash` scripts, `Homebrew` (via Linuxbrew), and `Ansible` to bootstrap the environment, installing essential tools like Neovim, Nushell, Starship, Wezterm, k3s, and FluxCD.

## Key Files & Directories

- **`run_bootstrap.sh`**: The primary entry point for bootstrapping the system. It installs Linuxbrew and Ansible, and then executes the setup playbook.
- **`ansible/setup.yml`**: An Ansible playbook responsible for installing necessary packages using `homebrew` and bootstrapping a `k3s` cluster when the target hostname is 'dell'.
- **`.chezmoi.toml.tmpl`**: The Chezmoi configuration template. Enables automatic Git commits/pushes and configures age encryption via an identity file (`~/.config/sops/age/keys.txt`) plus recipient pubkey.
- **`.chezmoiignore`**: Excludes the `bootstrap/` directory from being applied to the target.
- **`bootstrap/sops_age_key.txt.age`**: Passphrase-encrypted age identity. Source of truth for the SOPS/chezmoi age key. Not applied to the target directly; decrypted on first apply by the `run_onchange_before_` script.
- **`run_onchange_before_00_decrypt_sops_age_key.sh.tmpl`**: Runs before file apply. Provisions `~/.config/sops/age/keys.txt` by decrypting the blob with the user's passphrase. Skips if the key file already exists. Re-runs if the encrypted blob's hash changes.
- **`dot_config/`**: Contains configurations for various tools managed by Chezmoi:
  - **`nushell/`**: Nushell environment and configuration files (`config.nu`, `env.nu`).
  - **`starship.toml`**: Starship prompt configuration.
  - **`nvim/`**: A full Neovim configuration built on the [LazyVim](https://github.com/LazyVim/LazyVim) starter template.
- **`dot_wezterm.lua`**: Configuration for the Wezterm terminal emulator.

## Secrets & Encryption

Age encryption uses identity-file mode (not passphrase mode), so individual encrypted files in the source tree decrypt without prompting. Only the bootstrap blob (`bootstrap/sops_age_key.txt.age`) is passphrase-encrypted — decrypted exactly once per machine.

- **Recipient pubkey**: `age16cervjwzspavujv5u4ew8hrtl5zaud7g53ql0395w4u5mf78fpnqs72w82`
- **Identity location**: `~/.config/sops/age/keys.txt` (chmod 600)
- **Encrypted files in source**: any file matching the `encrypted_` chezmoi prefix (e.g. `private_dot_ssh/encrypted_private_id_ed25519.age`).
- **SOPS-encrypted env file**: `dot_secrets.sops.env` — decrypted to `~/.secrets.env` by `run_onchange_after_10_decrypt_secrets.sh.tmpl` using the same age identity.

To add a new encrypted file:
```bash
chezmoi add --encrypt <path>
```

## Building and Running (Usage)

This repository is intended to be used directly with `chezmoi`.

1.  **Bootstrapping a new machine:**
    Install `age` and `chezmoi` first (the `run_before_` script needs `age` available to decrypt the SOPS age identity):
    ```bash
    # macOS / Linuxbrew
    brew install age chezmoi
    ```
    Then initialize and apply. You will be prompted for the age passphrase exactly once to unlock the SOPS age identity:
    ```bash
    chezmoi init --apply <your-repo-url>
    ```
    The apply will:
    1. Run `run_onchange_before_00_decrypt_sops_age_key.sh` — prompts for the age passphrase, writes `~/.config/sops/age/keys.txt`.
    2. Apply dotfiles, decrypting `encrypted_*` files transparently with the identity.
    3. Run `run_bootstrap.sh` — installs Linuxbrew, Ansible, and runs the setup playbook.
    4. Run `run_onchange_after_10_decrypt_secrets.sh` — decrypts `dot_secrets.sops.env` to `~/.secrets.env` via SOPS.

    Subsequent `chezmoi apply` invocations require no prompts.

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
