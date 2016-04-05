
# Copied from https://github.com/nicknisi/dotfiles/blob/master/zsh/prompt.zsh
# heavily inspired by the wonderful pure theme
# https://github.com/sindresorhus/pure

# needed to get things like current git branch
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git # You can add hg too if needed: `git hg`
zstyle ':vcs_info:git*' use-simple true
zstyle ':vcs_info:git*' max-exports 2
zstyle ':vcs_info:git*' formats ' %b' 'x%R'
zstyle ':vcs_info:git*' actionformats ' %b|%a' 'x%R'

autoload colors && colors

git_dirty() {
  # check if we're in a git repo
  command git rev-parse --is-inside-work-tree &>/dev/null || return

  # check if it's dirty
  command git diff --quiet --ignore-submodules HEAD &>/dev/null;
  if [[ $? -eq 1 ]]; then
    echo "%F{red}✗%f"
  else
    echo "%F{green}✔%f"
  fi
}

# get the status of the current branch and it's remote
# If there are changes upstream, display a ⇣
# If there are changes that have been committed but not yet pushed, display a ⇡
git_arrows() {
  # do nothing if there is no upstream configured
  command git rev-parse --abbrev-ref @'{u}' &>/dev/null || return

  local arrows=""
  local status
  arrow_status="$(command git rev-list --left-right --count HEAD...@'{u}' 2>/dev/null)"

  # do nothing if the command failed
  (( !$? )) || return

  # split on tabs
  arrow_status=(${(ps:\t:)arrow_status})
  local left=${arrow_status[1]} right=${arrow_status[2]}

  (( ${right:-0} > 0 )) && arrows+="%F{011}⇣%f"
  (( ${left:-0} > 0 )) && arrows+="%F{012}⇡%f"

  echo $arrows
}

# Displays the exec time of the last command if set threshold was exceeded
#
cmd_exec_time() {
  local stop=`date +%s`
  local start=${cmd_timestamp:-$stop}
  let local elapsed=$stop-$start

  local human=" "
  local days=$(( elapsed / 60 / 60 / 24 ))
  local hours=$(( elapsed / 60 / 60 % 24 ))
  local minutes=$(( elapsed / 60 % 60 ))
  local seconds=$(( elapsed % 60 ))
  (( days > 0 )) && human+="${days}d "
  (( hours > 0 )) && human+="${hours}h "
  (( minutes > 0 )) && human+="${minutes}m "
  human+="${seconds}s"
  [ $elapsed -gt 5 ] && echo ${human}

}

# Get the intial timestamp for cmd_exec_time
#
preexec() {
  cmd_timestamp=`date +%s`
}

# indicate a job (for example, vim) has been backgrounded
# If there is a job in the background, display a ✱
suspended_jobs() {
  local sj
  sj=$(jobs 2>/dev/null | tail -n 1)
  if [[ $sj == "" ]]; then
    echo ""
  else
    echo "%{$FG[208]%}✱%f"
  fi
}

precmd() {
  vcs_info
  print -P '\n%F{33}%~%F{yellow}$(cmd_exec_time)%f'
}
