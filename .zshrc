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

# Path to oh-my-zsh installation.
export ZSH=/usr/share/oh-my-zsh/

# Preferred editor
export EDITOR='nvim'
export VISUAL='nvim'

######################################################################################
# OH MY ZSH
######################################################################################

source $ZSH/oh-my-zsh.sh

# Plugins
plugins=(git vi-mode)
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Enable command auto-correction.
ENABLE_CORRECTION="true"

# Command execution time stamp shown in the history command output
HIST_STAMPS="dd.mm.yyyy"

# Controls whether the cursor style is changed when switching vi modes
VI_MODE_SET_CURSOR=true

######################################################################################
# ALIASES
######################################################################################

# Timer
alias tm='$HOME/Scripts/timer.sh'

# My backups
alias gd='$HOME/Scripts/backup-googledrive.sh'

# My notes
alias td='$EDITOR $HOME/Documents/TODO.txt'

# Protects against stupid mistakes :)
alias rm='rm -I'

# List
alias ls='ls --color=auto'
alias la='ls -a'
alias ll='ls -lah'
alias l='ls'
alias l.="ls -A | egrep '^\.'"

# Package management
alias yas='yay -S'
alias yasu='yay -Syu'
alias yar='yay -Rsn'
alias yaq='yay -Qi'
alias yaqi='yay -Qi | grep'
alias yac='yay -Yc'

# Programs
alias v='nvim'
alias weather='curl wttr.in'

# Edit important configuration files
alias nz="$EDITOR $HOME/.zshrc"
alias nv="$EDITOR $HOME/.config/nvim/init.vim"
alias na="$EDITOR $HOME/.config/alacritty/alacritty.yml"

# Shutdown or reboot
alias sd="shutdown now"
alias rb="reboot"

# Dotfiles bare git repo
alias dot="/usr/bin/git --git-dir=$HOME/dotfiles-git/ --work-tree=$HOME"

# Colorize the grep command output for ease of use (good for log files)
alias grep='grep --color=auto'

# Readable output for df
alias df='df -h'

# Free
alias free="free -mt"

# Recent Installed Packages
alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"
alias riplong="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -3000 | nl"

# Cleanup orphaned packages
alias cleanup='sudo pacman -Rns $(pacman -Qtdq)'

# Search content with ripgrep
alias rg="rg --sort path"

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
# POWERLEVEL10K
######################################################################################

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
