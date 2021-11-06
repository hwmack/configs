#!/bin/bash

# Homebrew should be installed (even on Linux)


# List of things that need to be installed (maybe in the future it will install this stuff for us):
# - Rust
# - Fish
# - Starship (prompt)
# - bat
# - exa
# - fd
# - cheat
# - neovim

#######################################
# HELPERS
#######################################

# Check if the current OS is supported
is_unsupported_os() {
    local kernel_name=$(uname -s)
    [[ $kernel_name == "Darwin" || $kernel_name == "Linux" ]] 

    if [ "$?" -eq "1" ]; then
        echo "Your current OS is not supported"
        exit
    fi
}
is_unsupported_os # Run this early to check if we need to exit

# Get correct working directory
get_working_dir() {
    # Had some issues around the difference between being sourced and ran
    if [ $(dirname "$0") == "." ]; then
        echo $(pwd)
    else
        echo $(dirname "$0")
    fi
}

# Symlink directory
symlink() {
    # $1 is the directory we are symlinking 
    ln -sf $WORKING_DIR/"$1" $CONFIG_DIR/
}

# Open the site in the browser
open_brew_site() {
    open 'https://brew.sh/'
    read -p "Please install Brew for your system. Then press enter to continue"
}

# NOTE: Dont need these because they will be created automatically
# Create the directories that we will need
# mkdir -p $CONFIG_DIR
# I like putting my own personal scripts in here
# mkdir -p $HOME/bin

#######################################
# SETUP FUNCTIONS
#######################################

# Ensure all needed cli tools are installed
install_cli_tools() {
    echo "unimplimented!"
}

symlink_config_dir() {
    symlink
}

after_symlink_steps() {
    # Create the tmux config which will source the correct one inside .config
    echo "source-file \"${HOME}/.config/tmux/tmux.conf\"" > ~/.tmux.conf

    # Get the community cheatsheets
    # TODO This should probably be a git submodule
    local community_dir=$WORKING_DIR/cheat/cheatsheets/community
    if [[ ! -d $community_dir ]]; then
        git clone -q --depth 1 https://github.com/cheat/cheatsheets.git $community_dir
    fi

}

set_fish_as_shell() {
    chsh -s $(which fish)
    if [ "$?" -eq "0" ]; then
        echo "Could not set fish as default shell"
    fi
}

# Install the configurations into
install() {
    echo install
}

update() {
    symlink_config_dir

    # FIXME How to setup firefox?
    # TODO Need to add git configs
}

edit() {
    echo edit
}

uninstall() {
    echo uninstall
}

#######################################
# GLOBAL VARIABLES
#######################################
CONFIG_DIR=$HOME/.config
WORKING_DIR=$(get_working_dir)/cli

#######################################
# MAIN
#######################################
main() {
    # Handle any args given
    case $1 in
        install)
            install
            ;;
        update)
            update
            ;;
        edit)
            edit
            ;;
        uninstall)
            uninstall
            ;;
        shell)
            cd $(get_working_dir)
            bash --rcfile $0
            ;;
        *)
            local name=$(basename "$0")
            printf "$name:\nusage: $name install|update|edit|uninstall|shell"
            ;;
    esac
}
    

# If sourced, display a message on how to exit
# NOTE: Robustness is not required 
$(return >/dev/null 2>&1)
if [ "$?" -eq "0" ]; then
    echo 'Loading shell functions for testing'
    echo 'To exit: <C-d>'
else
    # Run the main method
    main $@
fi
