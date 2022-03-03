export EDITOR='nvim'
export VISUAL='nvim'
export MANPAGER='less -s -M +Gg'
#export WORDCHARS='*?_-.[]~=&;!#$&(){}<>'
if test $XDG_SESSION_TYPE = "wayland"
    export QT_QPA_PLATFORM=wayland
end

export cheat () { curl cht.sh/$1 }

# Devel environment exports
#export JAVA_HOME=/usr/lib64/jvm/java-1.8.0-openjdk
export PATH="$PATH:$HOME/learning/flutter/flutter"
export PATH="$PATH:/usr/lib64/ruby/gems/2.7.0/gems"
