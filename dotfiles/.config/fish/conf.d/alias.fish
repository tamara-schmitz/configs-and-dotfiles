alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias diff='diff --color=auto'

alias vim='nvim'
alias vi='nvim'
alias ll='ls -lh'
alias lah='ls -lah'
alias o='xdg-open'
alias map='telnet mapscii.me'

if test $XDG_SESSION_TYPE = "wayland"
    export QT_QPA_PLATFORM=wayland
end

if type -q podman
    alias docker='podman'
else if type -q docker
    alias podman='docker'
end

alias gtel='~/bin/geekotel/gtel.py'
***REMOVED***
***REMOVED***
alias aliases='less ~/.config/fish/conf.d/alias.fish'
alias aliasedit='vi ~/.config/fish/conf.d/alias.fish'
