#!/bin/bash
#
# This script shall attempt to set global git aliases
# as they are listed on git_aliases.json 
# 
# Developer contact: taksjosephrefugio@gmail.com

GITCONFIG_FILE=$HOME/.gitconfig
GIT_ALIASES_SRCFILE="$(cd ..; pwd)/git_aliases"

remove_existing_aliases() {

	echo "Attempting to remove existing git aliases..."

	git config --global --remove-section alias && \
		echo "Existing Aliases removed successfully..." || \
		if [[ $? -eq 128 ]]; then \
			echo ".gitconfig has no existing git aliases. All good to proceed."; \
		else \
			echo "Code $?: Something went wrong when trying "git config --global --remove-section alias"";
		fi
}

set_git_aliases() {

	if [[ -f $GIT_ALIASES_SRCFILE ]]; then
		echo "Custom git_aliases file found at $(pwd)" 
		echo "Attempting to set custom git aliases..."
		cat $GIT_ALIASES_SRCFILE >> $GITCONFIG_FILE
		echo "Custom git aliases has been set. Kindly check by trying them out."
	else
		echo "Unable to locate git_aliases file at $(pwd)"
		echo "Failed to set custom git aliases..."
		echo "Make sure the file git_aliases exists at $(pwd)"
		exit 2
	fi
}


if [[ -f $GITCONFIG_FILE ]]; then
	echo ".gitconfig file found at $HOME"
else
	echo "Unable to locate $HOME/.gitconfig. Are you sure you have git installed?"
	exit 1
fi

remove_existing_aliases
set_git_aliases
echo "Done... Goodbye!"
