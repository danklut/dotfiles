# Path
export PATH=$HOME/.local/bin:/usr/local/bin:$PATH

# WSL specific
if [[ $(uname -a) =~ "microsoft" ]] then
	alias ex=/mnt/c/Windows/explorer.exe
	# Copy .ssh
	upd_ssh(){
		rm -rf ~/.ssh
		/bin/cp -rf /mnt/c/Users/maple3142/.ssh ~/.ssh
		chmod 600 ~/.ssh/*
	}
fi

# Zsh settings
ZSH_DISABLE_COMPFIX="true"
HIST_STAMPS="yyyy-mm-dd"

# Oh my zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="ys"
plugins=(
	docker # docker autocomplete
	sudo # press ESC two times to prepend `sudo`
	zsh-autosuggestions # suggest command from history
	fast-syntax-highlighting # zsh syntax highlighting
	zsh_reload # `src` to reload and recompile .zshrc
)
source $ZSH/oh-my-zsh.sh

# Lang
export LANG=en_US.UTF-8

# Editor
export EDITOR=vim

# Keychain
if (( $+commands[keychain] )) then
	eval `keychain --quiet --eval --agents ssh id_rsa`
fi

# Node.js (uses tj/n)
if (( $+commands[n] )) then
	export N_PREFIX="$HOME/.n"
	export PATH="$N_PREFIX/bin:$PATH"
fi
if (( $+commands[yarn] )) then
	export PATH="$HOME/.yarn/bin:$PATH"
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
