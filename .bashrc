export SHELL=/bin/bash
export LS_OPTIONS='--color=auto -F --show-control-chars'
export PATH=$PATH:~/.npm-global/bin
eval "`dircolors`"
alias ls='ls $LS_OPTIONS'
alias ll='ls $LS_OPTIONS -lrt'

# alias repl='clojure -A:rebel-readline'
