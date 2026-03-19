$env.PATH = ($env.PATH | split row (char esep) | prepend [
    ($nu.home-path | path join "bin"),
    ($nu.home-path | path join ".local" "bin"),
    ($nu.home-path | path join ".cargo" "bin"),
    "/opt/homebrew/bin",
    "/usr/local/bin"
] | uniq)

$env.EDITOR = "nvim"
$env.config.buffer_editor = "nvim"
$env.config.show_banner = false
$env.config.shell_integration.osc133 = false

let autoload = ($nu.data-dir | path join "vendor" "autoload")
mkdir $autoload
starship init nu | save -f ($autoload | path join "starship.nu")
