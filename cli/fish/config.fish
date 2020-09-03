
# Init the Starship prompt
starship init fish | source

##############################################
#
# ENVIRONMENT VARIABLES
#
##############################################

setenv TERM xterm-256color

# Add cargo to path
setenv PATH "$PATH:$HOME/.cargo/bin"

# Coloured man output
setenv LESS_TERMCAP_mb \e'[01;31m'       # begin blinking
setenv LESS_TERMCAP_md \e'[01;38;5;74m'  # begin bold
setenv LESS_TERMCAP_me \e'[0m'           # end mode
setenv LESS_TERMCAP_se \e'[0m'           # end standout-mode
setenv LESS_TERMCAP_so \e'[38;5;246m'    # begin standout-mode - info box
setenv LESS_TERMCAP_ue \e'[0m'           # end underline
setenv LESS_TERMCAP_us \e'[04;38;5;146m' # begin underline


##############################################
#
# ALIASES
#
##############################################
alias vim nvim
alias c cargo

# Git shortcuts
alias g git
alias gc "git checkout"
alias ga "git add -p"

alias ls exa
alias ll "exa -l"
alias la "exa -la"

alias cat bat

alias year "cal -y"
alias month "cal"

# Shortcuts for specific directories
alias documents "cd ~/Documents"
alias downloads "cd ~/Downloads"
alias projects "cd ~/projects"

# Shortcuts to edit important files
alias etmux "vim ~/.config/tmux/tmux.conf"
alias evim "vim ~/.config/nvim/init.vim"
# NOTE There is a function to edit the fish config below


##############################################
#
# Bind shortcuts
#
##############################################

# Setup fzf when pressing Ctrl+r
bind -M insert \cr 'commandline -j (history | fzf)'


##############################################
#
# HELPER FUNCTIONS
#
##############################################

# Run a command in bash
function ! 
	bash -c "$argv"
end

# Run the last command with sudo
function oops
	eval command sudo $history[1]
end

# Edit the cargo toml file of a repo
function ecargo
	set -l current $PWD
	while test \( $PWD != "/" \) -a \( ! -f cargo.toml \)
		cd ..
	end

	if test -f cargo.toml
		vim cargo.toml
	else
		echo "Could not find Cargo file"
	end

	cd $current
end

# Edit the fish config
function efish 
	set -l fish_path ~/.config/fish/config.fish
	vim $fish_path
	source $fish_path
	echo Updated fish config: $fish_path
end

# Now start the session!
if status is-interactive
and not set -q TMUX
    exec tmux
end

