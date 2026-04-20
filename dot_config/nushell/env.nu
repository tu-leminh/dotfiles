$env.EDITOR = "nvim"

$env.PATH = ($env.PATH | split row (char esep) | prepend [
    ($nu.home-dir | path join "bin"),
    ($nu.home-dir | path join ".local" "bin"),
    ($nu.home-dir | path join ".cargo" "bin"),
    ($nu.home-dir | path join ".npm-global" "bin"),
    "/home/linuxbrew/.linuxbrew/bin",
    "/home/linuxbrew/.linuxbrew/sbin",
    "/opt/homebrew/bin",
    "/usr/local/bin"
] | uniq)

$env.config = {
    buffer_editor: "nvim"
    show_banner: false
    shell_integration: {
        osc133: false
    }
}
