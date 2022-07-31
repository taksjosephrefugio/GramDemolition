#!/bin/bash
#
# This script shall attempt to set bash aliases for Ubuntu Machines 
# 
# Developer contact: taksjosephrefugio@gmail.com

COMMANDCENTER="$(cd ..; pwd)/CommandCenter"
BASH_ALIASES="$(cd ..; pwd)/.bash_aliases"

# Copy Command Center to home dir
cp -r $COMMANDCENTER $HOME && \
echo "Copy CommandCenter to $HOME successful!" || \
{ echo "Failed to copy CommandCenter to $HOME"; exit 1; }

# Set command aliases in HOME as executables
chmod +x $HOME/CommandCenter/*

# Copy .bash_aliases to home dir
cp $BASH_ALIASES $HOME && \
echo "Copy .bash_aliases to $HOME successful!" || \
{ echo "Failed to copy .bash_aliases to $HOME"; exit 1; }

# Remove existing aliases
unalias -a

# Set custom aliases by restarting .bashrc
source $HOME/.bashrc
