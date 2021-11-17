fish_add_path ~/.local/bin

set -Ux EDITOR nvim

abbr -g rf 'source ~/.config/fish/config.fish'

abbr -g g    'git'
abbr -g ga   'git add'
abbr -g gb   'git branch'
abbr -g gbd  'git branch -d'
abbr -g gbdd 'git branch -D'
abbr -g gc   'git commit -m'
abbr -g gca  'git commit --amend'
abbr -g gcp  'git cherry-pick'
abbr -g gd   'git diff'
abbr -g gf   'git fetch'
abbr -g gl   'git log'
abbr -g gm   'git merge'
abbr -g gp   'git push'
abbr -g gpf  'git push --force-with-lease'
abbr -g grb  'git rebase'
abbr -g gs   'git status'
abbr -g gst  'git stash'
abbr -g gsw  'git switch'
abbr -g gcd  'cd (git rev-parse --show-toplevel)'

abbr -g chd  'chezmoi diff'
abbr -g chcd 'chezmoi cd'
abbr -g cha  'chezmoi -v apply'
abbr -g che  'chezmoi edit'

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
