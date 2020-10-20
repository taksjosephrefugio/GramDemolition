#!/bin/bash

LAYOUT_NAME=bash_layout
LAYOUT_DIR=$(cd .. || exit; pwd)
LAYOUT="$LAYOUT_DIR/$LAYOUT_NAME"
BASHRC="$HOME/.bashrc"

if [[ -f $LAYOUT ]]; then
	echo "$LAYOUT found... "
	echo "Appending $LAYOUT_NAME to $BASHRC "
	((echo; cat $LAYOUT) >> $BASHRC) && echo "Appending successful! "
	echo "NOTE: Restart shell session for changes to take into effect "
else
	echo "$LAYOUT_NAME file doesn not exist on $LAYOUT_DIR"
fi
