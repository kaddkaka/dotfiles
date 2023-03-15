fish_add_path ~/.local/bin
fish_add_path ~/.nimble/bin
fish_add_path ~/.cargo/bin

set -gx EDITOR nvim

function fish_user_key_bindings
    bind \ca 'fg'
end

abbr -g rf 'source ~/.config/fish/config.fish'

abbr -g gg   'git grep'
abbr -g gf   'git fetch'
abbr -g gd   'git diff'
abbr -g gr   'git rebase'
abbr -g gs   'git status'
abbr -g gst  'git stash'
abbr -g gsw  'git switch'
abbr -g ga   'git add'
abbr -g gc   'git commit -m'
abbr -g gca  'git commit --amend'
abbr -g gcp  'git cherry-pick'
abbr -g gl   'git log'
abbr -g gm   'git merge'
abbr -g gp   'git push'
abbr -g gpf  'git push --force-with-lease'
abbr -g gcd  'cd (git rev-parse --show-toplevel)'

abbr -g gjg   'git jump grep'
abbr -g gjd   'git jump diff'
abbr -g gjm   'git jump merge'

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

#zoxide init fish | source
starship init fish | source

source ~/.config/fish/shell-integration.fish
