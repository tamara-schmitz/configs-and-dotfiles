export EDITOR='nvim'
export VISUAL='nvim'
export MANPAGER='less -s -M +Gg'
#export WORDCHARS='*?_-.[]~=&;!#$&(){}<>'
if test $XDG_SESSION_TYPE = "wayland"
    export QT_QPA_PLATFORM=wayland
end

# Devel environment exports
