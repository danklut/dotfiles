# Keychain
if (( $+commands[keychain] )) && [[ -a ~/.ssh/id_rsa ]] then
	eval `keychain --quiet --eval --agents ssh id_rsa`
fi

# Powerlevel10k Instant Prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Zsh settings
ZSH_DISABLE_COMPFIX="true"
HIST_STAMPS="yyyy-mm-dd"
zstyle ':completion:*' menu select

# ZInit
source ~/.zinit/bin/zinit.zsh

zinit snippet OMZL::history.zsh
zinit wait lucid for \
  OMZL::key-bindings.zsh \
  OMZP::sudo

zinit wait lucid light-mode for \
  zsh-users/zsh-history-substring-search \
  atinit"zicompinit; zicdreplay" \
      zdharma/fast-syntax-highlighting \
  atload"_zsh_autosuggest_start" \
      zsh-users/zsh-autosuggestions \
  blockf atpull"zinit creinstall -q ." \
      zsh-users/zsh-completions

zinit ice depth=1
zinit light romkatv/powerlevel10k

zinit lucid for \
  as"program" pick"bin/n" tj/n

zinit lucid from"gh-r" as"program" for \
  pick"jq-*" mv"jq-* -> jq" stedolan/jq \
  pick"ripgrep-*-linux-*" extract mv"*/rg -> rg" BurntSushi/ripgrep \
  pick"exa-linux-*" extract mv"exa-* -> exa" ogham/exa \
  pick"bat-linux-*" extract mv"*/bat -> bat" @sharkdp/bat
  
# Path
export PATH=$HOME/.local/bin:/usr/local/bin:$PATH

# WSL specific
if [[ -v WSL_DISTRO_NAME ]] then
	alias ex=/mnt/c/Windows/explorer.exe
	# Copy .ssh
	upd_ssh(){
		rm -rf ~/.ssh
		/bin/cp -rf "/mnt/c/Users/$(whoami)/.ssh" ~/.ssh
		chmod 600 ~/.ssh/*
	}
	# Windows Path handling for performance
	WIN_PATH=$(echo $PATH | tr ':' '\n' | grep '/mnt/c' | tr '\n' ':' | sed 's/.$//')
	export PATH=$(echo $PATH | tr ':' '\n' | grep -v '/mnt/c' | tr '\n' ':' | sed 's/.$//')
	zinit wait'3' lucid atinit'export PATH="$PATH:$WIN_PATH"' nocd for /dev/null
fi

# Fix ssh autocomplete
zstyle ':completion:*:ssh:argument-1:*' tag-order hosts
h=()
if [[ -r ~/.ssh/config ]]; then
  h=($h ${${${(@M)${(f)"$(cat ~/.ssh/config)"}:#Host *}#Host }:#*[*?]*})
fi
if [[ $#h -gt 0 ]]; then
  zstyle ':completion:*:ssh:*' hosts $h
  zstyle ':completion:*:slogin:*' hosts $h
fi

# Lang
export LANG=en_US.UTF-8

# Editor
export EDITOR=vim

# Node.js (uses tj/n)
if (( $+commands[n] )) then
	export N_PREFIX="$HOME/.n"
	export PATH="$N_PREFIX/bin:$PATH"
fi
if (( $+commands[yarn] )) then
	export PATH="$HOME/.yarn/bin:$PATH"
fi

# Python (Poetry)
if [[ -d ~/.poetry ]] then
	export PATH="$HOME/.poetry/bin:$PATH"
fi

# Rust (uses rustup)
if [[ -d ~/.cargo ]] then
	source ~/.cargo/env
fi

# Golang
if [[ -d ~/.go ]] then
	export GOROOT="$HOME/.go"
	export PATH="$GOROOT/bin:$PATH"
fi

# CHROME_PATH
if (( $+commands[chromium] )) then
	export CHROME_PATH="$(which chromium)"
fi

# Aliases
alias ga="git add -A"
alias gcm="git commit -m"
alias gp="git push"

if (( $+commands[exa] )) then
	alias ls="exa"
	alias ll="exa -l"
	alias la="exa -la"
fi
if (( $+commands[bat] )) then
	alias cat="bat -p"
fi

# P10k Initialize
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

