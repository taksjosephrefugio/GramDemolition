#!/bin/bash
#
# If .vimrc already exists on $HOME directory, then append contents of .vimrc
# file on GramDemolition/ directory. If no .vimrc file currently exists on 
# user's $HOME dir, then copy .vimrc file on GramDemolition/ directory to
# $HOME directory.
#
# Developer contact: taksjosephrefugio@gmail.com

CUSTOM_VIMRC=$(cd .. || exit; pwd)/.vimrc
VIMRC_LOCATION="$HOME/.vimrc"

if [[ -f $VIMRC_LOCATION ]]; then
	echo ".vimrc found on $VIMRC_LOCATION"
	echo "Appending $CUSTOM_VIMRC to $VIMRC_LOCATION "
	((echo; cat $CUSTOM_VIMRC) >> $VIMRC_LOCATION) && \
		echo "Appending successful! "
else
	echo "No existing .vimrc found on $HOME..."
	echo "Creating .vimrc file on $HOME"
	cp -v $CUSTOM_VIMRC $HOME && echo ".vimrc file is now set..."
fi
