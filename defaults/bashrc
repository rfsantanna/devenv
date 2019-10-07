# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

# History Options
# Don't put duplicate lines in the history.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
#
# Ignore some controlling instructions
# HISTIGNORE is a colon-delimited list of patterns which should be excluded.
# The '&' is a special pattern which suppresses duplicate entries.
# export HISTIGNORE=$'[ \t]*:&:[fb]g:exit'
export HISTIGNORE=$'[ \t]*:&:[fb]g:exit:ls' # Ignore the ls command as well
# Whenever displaying the prompt, write the previous line to disk
export PROMPT_COMMAND="history -a"
# Date and Time in HISTORY
export HISTTIMEFORMAT="%d/%m/%y %T "


# Umask
#
# /etc/profile sets 022, removing write perms to group + others.
# Set a more restrictive umask: i.e. no exec perms for others:
# umask 027
# Paranoid: neither group nor others have any perms:
# umask 077

# Functions
#
# Some people use a different file for functions
# if [ -f "${HOME}/.bash_functions" ]; then
#   source "${HOME}/.bash_functions"
# fi
#
# Some example functions:
#
# a) function settitle
# settitle () 
# { 
#   echo -ne "\e]2;$@\a\e]1;$@\a"; 
# }
# 
# b) function cd_func
# This function defines a 'cd' replacement function capable of keeping, 
# displaying and accessing history of visited directories, up to 10 entries.
# To use it, uncomment it, source this file and try 'cd --'.
# acd_func 1.0.5, 10-nov-2004
# Petar Marinov, http:/geocities.com/h2428, this is public domain
cd_func ()
{
  local x2 the_new_dir adir index
  local -i cnt

  if [[ $1 ==  "--" ]]; then
    dirs -v
    return 0
  fi

  the_new_dir=$1
  [[ -z $1 ]] && the_new_dir=$HOME

  if [[ ${the_new_dir:0:1} == '-' ]]; then
    #
    # Extract dir N from dirs
    index=${the_new_dir:1}
    [[ -z $index ]] && index=1
    adir=$(dirs +$index)
    [[ -z $adir ]] && return 1
    the_new_dir=$adir
  fi

  #
  # '~' has to be substituted by ${HOME}
  [[ ${the_new_dir:0:1} == '~' ]] && the_new_dir="${HOME}${the_new_dir:1}"

  #
  # Now change to the new dir and add to the top of the stack
  pushd "${the_new_dir}" > /dev/null
  [[ $? -ne 0 ]] && return 1
  the_new_dir=$(pwd)

  #
  # Trim down everything beyond 11th entry
  popd -n +11 2>/dev/null 1>/dev/null

  #
  # Remove any other occurence of this dir, skipping the top of the stack
  for ((cnt=1; cnt <= 10; cnt++)); do
    x2=$(dirs +${cnt} 2>/dev/null)
    [[ $? -ne 0 ]] && return 0
    [[ ${x2:0:1} == '~' ]] && x2="${HOME}${x2:1}"
    if [[ "${x2}" == "${the_new_dir}" ]]; then
      popd -n +$cnt 2>/dev/null 1>/dev/null
      cnt=cnt-1
    fi
  done

  return 0
}
alias cd=cd_func


# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

# Aliases
#
# Misc :)
alias less='less -r'                          # raw control characters
alias whence='type -a'                        # where, of a sort
alias grep='grep --color'                     # show differences in colour
alias egrep='egrep --color=auto'              # show differences in colour
alias fgrep='fgrep --color=auto'              # show differences in colour

alias ls="ls --color"
alias l="ls --color"
alias ll="ls --color -l"
alias la="ls --color -lA"

alias grep='grep --color'                     # show differences in colour
alias egrep='egrep --color=auto'              # show differences in colour
alias fgrep='fgrep --color=auto'              # show differences in colour

# ----------------------
# Git Aliases
# ----------------------
alias Ga='git add'
alias Gaa='git add .'
alias Gaaa='git add --all'
alias Gau='git add --update'
alias Gb='git branch'
alias Gbd='git branch --delete '
alias Gc='git commit'
alias Gcm='git commit --message'
alias Gcf='git commit --fixup'
alias Gco='git checkout'
alias Gcob='git checkout -b'
alias Gcom='git checkout master'
alias Gcos='git checkout staging'
alias Gcod='git checkout develop'
alias Gd='git diff'
alias Gda='git diff HEAD'
alias Gi='git init'
alias Glg='git log --graph --oneline --decorate --all'
alias Gld='git log --pretty=format:"%h %ad %s" --date=short --all'
alias Gm='git merge --no-ff'
alias Gma='git merge --abort'
alias Gmc='git merge --continue'
alias Gp='git pull'
alias Gpr='git pull --rebase'
alias Gr='git rebase'
alias Gs='git status'
alias Gss='git status --short'
alias Gst='git stash'
alias Gsta='git stash apply'
alias Gstd='git stash drop'
alias Gstl='git stash list'
alias Gstp='git stash pop'
alias Gsts='git stash save'

# ----------------------
# Git Functions
# ----------------------
# Git log find by commit message
function Glf() { git log --all --grep="$1"; }


### Windows aliases (MSYS2, GitBash)
# alias winhome="cd /c/users/$USERNAME"
# alias python='winpty python.exe'
# 
if [ `pwd` == '/' ]
  then
  cd $HOME
fi
###

# Autocomplete with History when press up arrow
bind '"\e[A":history-search-backward'
# Ignore case on autocompletion
bind 'set completion-ignore-case on'


. ~/.bash_prompt
