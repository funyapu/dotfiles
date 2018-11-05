export PATH=/usr/local/share/npm/bin:/usr/local/bin:/usr/local/sbin:/usr/local/share:$PATH
#export PATH="$HOME/.rbenv/bin:$PATH"
#eval "$(rbenv init -)"
export PATH=$HOME/.nodebrew/current/bin:$PATH
export PATH="$PATH:`yarn global bin`"
export PATH="$PATH:$HOME/.config/yarn/global/node_modules/.bin/"
#export PATH=$PATH:./node_modules/.bin

autoload -U compinit
compinit
export LANG=ja_JP.UTF-8
plugins=(git osx)

HISTFILE=$HOME/.zsh-history
HISTSIZE=100000
SAVEHIST=100000
setopt extended_history
function history-all { history -E 1 }
setopt share_history

alias ls="ls -G"
alias ll="ls -lG"
alias la="ls -laG"
#alias rm='rmtrash'
alias vi='vim'

case $OSTYPE in
  cygwin*)
  alias open="cygstart"
esac

autoload colors
colors
PROMPT="%{${fg[yellow]}%}[%n@] %{${reset_color}%}"
PROMPT2="%{${fg[yellow]}%}%_> %{${reset_color}%}"
SPROMPT="%{${fg[red]}%}correct: %R -> %r [nyae]? %{${reset_color}%}"
RPROMPT="%{${fg[green]}%}[%~]%{${reset_color}%}"

export PATH=$PATH:/sbin
alias notify='terminal-notifier -message "done!" -sound Pop'

# The next line updates PATH for the Google Cloud SDK.
source $HOME/google-cloud-sdk/path.zsh.inc

# The next line enables bash completion for gcloud.
source $HOME/google-cloud-sdk/completion.zsh.inc
