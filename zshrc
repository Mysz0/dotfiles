setopt HIST_IGNORE_DUPS
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e

zstyle :compinstall filename '/home/dog/.zshrc'
autoload -Uz compinit
compinit

# --- GIT CONFIG (Official Script) ---
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWUPSTREAM="auto"

# Source from the directory we created
source /usr/share/zsh/plugins/git-prompt/git-prompt.sh

setopt PROMPT_SUBST

# Your logic for Green (clean) / Red (dirty)
parse_git_branch() {
  local branch
  branch=$(__git_ps1 "%s")
  if [ -n "$branch" ]; then
    if git diff --quiet 2>/dev/null >&2; then
      echo "%F{green}($branch)%f "
    else
      echo "%F{red}($branch)%f "
    fi
  fi
}

# --- THE PROMPT (Your exact style) ---
PROMPT='%1~ $(parse_git_branch)➤ '

# Fix the Delete key
bindkey "^[[3~" delete-char

# Aliases
alias v="nvim"
alias y="yazi"
alias ls='eza --icons --group-directories-first'
alias ff="fastfetch"

# ZSH_AUTOSUGGEST
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

export PATH=$PATH:/home/dog/.spicetify
export PATH="$PATH:/home/dog/.local/bin"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH="$HOME/.npm-global/bin:$PATH"
