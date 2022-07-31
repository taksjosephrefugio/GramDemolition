#!/bin/bash

LAYOUT_NAME=bash_layout
LAYOUT_DIR=$(cd .. || exit; pwd)
LAYOUT="$LAYOUT_DIR/$LAYOUT_NAME"
BASHRC="$HOME/.bashrc"

if [[ -f $LAYOUT ]]; then
	((echo; cat $LAYOUT) >> $BASHRC) && echo ">>> $LAYOUT_NAME Appending successful! "
else
	echo ">>> FAIL: $LAYOUT_NAME file doesn not exist on $LAYOUT_DIR"
fi
