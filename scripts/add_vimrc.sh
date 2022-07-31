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
	((echo; cat $CUSTOM_VIMRC) >> $VIMRC_LOCATION) && \
		echo ">>> SUCCESS: vimrc Update successful! "
else
	cp $CUSTOM_VIMRC $HOME && echo ">>> SUCCESS: .vimrc file is now set..."
fi
