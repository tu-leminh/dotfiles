$env.EDITOR = "nvim"
$env.config.buffer_editor = "nvim"
$env.config.show_banner = false
$env.config.shell_integration.osc133 = false

$env.PATH = ($env.PATH | split row (char esep) | prepend [
    ($nu.home-path | path join "bin"),
    ($nu.home-path | path join ".local" "bin"),
    ($nu.home-path | path join ".cargo" "bin"),
    ($nu.home-path | path join ".npm-global" "bin"),
    "/opt/homebrew/bin",
    "/usr/local/bin",
    (uv python find 3.12 | str trim | path dirname)
] | uniq)

$env.EDITOR = "nvim"
$env.config = {
    buffer_editor: "nvim"
    show_banner: false
    shell_integration: {
        osc133: false
    }
}
