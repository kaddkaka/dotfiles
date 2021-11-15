fish_add_path ~/.local/bin

set -Ux EDITOR nvim

abbr rf 'source ~/.config/fish/config.fish'

abbr g    'git'
abbr ga   'git add'
abbr gb   'git branch'
abbr gbd  'git branch -d'
abbr gbdd 'git branch -D'
abbr gc   'git commit -m'
abbr gca  'git commit --amend'
abbr gcp  'git cherry-pick'
abbr gd   'git diff'
abbr gf   'git fetch'
abbr gl   'git log'
abbr gm   'git merge'
abbr gp   'git push'
abbr gpf  'git push --force-with-lease'
abbr grb  'git rebase'
abbr gs   'git status'
abbr gst  'git stash'
abbr gsw  'git switch'
abbr gcd  'cd (git rev-parse --show-toplevel)'

abbr chd  'chezmoi diff'
abbr chcd 'chezmoi cd'
abbr cha  'chezmoi -v apply'
abbr che  'chezmoi edit'

abbr apti 'sudo apt install'
abbr aptu 'sudo apt update'
abbr aptr 'sudo apt remove'
abbr aptf 'sudo apt full-upgrade'

abbr v 'nvim'

abbr c 'clear'
abbr q 'exit'
abbr :q 'exit'

abbr rm 'rm -I'
abbr mkdir 'mkdir -p -v'

# Modern unix
#abbr cat 'bat'
#abbr ls 'lsd --icon always'

#zoxide init fish | source
starship init fish | source
