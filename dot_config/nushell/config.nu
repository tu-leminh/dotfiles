let autoload = ($nu.data-dir | path join "vendor" "autoload")
mkdir $autoload
starship init nu | save -f ($autoload | path join "starship.nu")
