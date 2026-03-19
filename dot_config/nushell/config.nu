$env.config.buffer_editor = "nvim"
$env.config.show_banner = false
$env.config.shell_integration.osc133 = false
mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")
