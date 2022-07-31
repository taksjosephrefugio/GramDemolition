#!/bin/bash
#
# This script shall attempt to set global git aliases
# as they are listed on git_aliases.json 
# 
# Developer contact: taksjosephrefugio@gmail.com

GITCONFIG_FILE=$HOME/.gitconfig
GIT_ALIASES_SRCFILE="$(cd ..; pwd)/git_aliases"

remove_existing_aliases() {
	git config --global --remove-section alias && \
		echo ">>> SUCCESS: Existing Aliases removed successfully..." || \
		if [[ $? -eq 128 ]]; then \
			echo ">>> .gitconfig has no existing git aliases. All good to proceed."; \
		else \
			echo ">>> FAIL: Code $?; Something went wrong when trying "git config --global --remove-section alias"";
		fi
}

set_git_aliases() {

	if [[ -f $GIT_ALIASES_SRCFILE ]]; then
		cat $GIT_ALIASES_SRCFILE >> $GITCONFIG_FILE
		echo ">>> SUCCESS: Custom git aliases has been set."
	else
		echo ">>> FAIL: Unable to locate git_aliases file at $(pwd)"
		exit 2
	fi
}


if [[ -f $GITCONFIG_FILE ]]; then
	remove_existing_aliases
	set_git_aliases
	echo ">>> Done... Goodbye!"
else
	echo "FAIL: Unable to locate $HOME/.gitconfig. Are you sure you have git installed?"
	exit 1
fi


