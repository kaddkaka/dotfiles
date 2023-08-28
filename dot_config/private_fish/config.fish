fish_add_path ~/.local/bin

set -Ux EDITOR nvim

abbr -g rf 'source ~/.config/fish/config.fish'

abbr -g gg   'git grep'
abbr -g gf   'git fetch'
abbr -g gd   'git diff'
abbr -g gr   'git rebase'
abbr -g gs   'git status'
abbr -g gst  'git stash'
abbr -g gsw  'git switch'
abbr -g gc   'git commit'
abbr -g gca  'git commit --amend'
abbr -g gpf  'git push --force-with-lease'

abbr -g apti 'sudo apt install'
abbr -g aptu 'sudo apt update'
abbr -g aptr 'sudo apt remove'
abbr -g aptf 'sudo apt full-upgrade'

abbr -g v 'nvim'

abbr -g c 'clear'
abbr -g q 'exit'
abbr -g :q 'exit'

abbr -g rm 'rm -I'
abbr -g mkdir 'mkdir -p -v'

# Modern unix
#abbr -g cat 'bat'
#abbr -g ls 'lsd --icon always'

#zoxide init fish | source
starship init fish | source

#source ~/.config/fish/shell-integration.fish
#source shell-integration.fish
