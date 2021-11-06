######################################################################################
# POWERLEVEL10K
######################################################################################

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source "/usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme"

######################################################################################
# ENVIRONMENT
######################################################################################

# Preferred editor
export EDITOR='nvim'
export VISUAL='nvim'

# For fuzzy finder to show hidden files
export FZF_DEFAULT_COMMAND='find .'

######################################################################################
# OH MY ZSH
######################################################################################

# Path to oh-my-zsh installation.
export ZSH=/usr/share/oh-my-zsh/

# Plugins
plugins=(git vi-mode zsh-autosuggestions)

# Command execution time stamp shown in the history command output
HIST_STAMPS="dd.mm.yyyy"

# Controls whether the cursor style is changed when switching vi modes
VI_MODE_SET_CURSOR=true

source $ZSH/oh-my-zsh.sh

######################################################################################
# ALIASES
######################################################################################

# Tmux
alias tx='tmux'

# Ranger
alias r='ranger'

# Mock text
alias mock='python $HOME/Scripts/mock.py'

# Check what GPU is being used
alias gpu='inxi -SGx'

# Timer
alias tm='$HOME/Scripts/timer.sh'

# Git
alias ga='git add'
alias gc='git commit -m'
alias gp='git push'
alias gs='git status'
alias gd='git diff'
alias gr='git reset'
alias gl='git log'

# My backups
alias gdr='$HOME/Scripts/backup-drive-rclone.sh'
alias bp='$HOME/Scripts/backup-plasma.sh'

# Protects against stupid mistakes :)
alias rm='rm -I'

# List
alias ls='ls --color=auto'
alias la='ls -A'
alias ll='ls -lA'
alias l='ls'
alias l.="ls -A | egrep '^\.'"
alias lg='ls | grep'
alias llg='ls -lA | grep'
alias lag='ls -A | grep'

# Package management
alias yas='yay -S'
alias yasu='yay -Syu'
alias yar='yay -Rsn'
alias yaq='yay -Qi'
alias yaqi='yay -Q --info'
alias yac='yay -Yc'
alias yaf='yay -F'

# Programs
alias v='nvim'
alias weather='curl wttr.in'

# Edit important configuration files
alias vz="$EDITOR $HOME/.zshrc"
alias vv="$EDITOR $HOME/.config/nvim/init.vim"
alias va="$EDITOR $HOME/.config/alacritty/alacritty.yml"
alias vx="$EDITOR $HOME/.xmonad/xmonad.hs"
alias vxb="$EDITOR $HOME/.config/xmobar/xmobarrc"
alias vtx="$EDITOR $HOME/.config/tmux/tmux.conf"

# Shutdown or reboot
alias sd="shutdown now"
alias rb="reboot"

# Dotfiles bare git repo
alias dot="/usr/bin/git --git-dir=$HOME/dotfiles-git/ --work-tree=$HOME"

# Colorize the grep command output for ease of use (good for log files)
alias grep='grep --color=auto'

# Readable output for df
alias df='df -h'

# Get the error messages from journalctl
alias jctle="journalctl -p 3 -xb"

# Extractor for all kinds of archives
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *.deb)       ar x $1      ;;
      *.tar.xz)    tar xf $1    ;;
      *.tar.zst)   tar xf $1    ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

######################################################################################
# THINGS THAT NEED TO BE AS LOW AS POSSIBLE
######################################################################################

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
