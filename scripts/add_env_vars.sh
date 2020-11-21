#!/bin/bash
#
# Developer contact: taksjosephrefugio@gmail.com
#

FAKE_BASHRC="$HOME/Downloads/fake_bashrc"
REPO_DIR="$(cd ..; pwd || exit)"


read_env_vars() {
    # Go through each line in env_vars
    while read line; do
        KEY=${line%=*}
        VALUE=${line#*=}
        echo $KEY
        echo $VALUE
    done < "$REPO_DIR/env_vars"
}


# Find line numbers of previously set Custom Environmental Variables
find_line_numbers() {
    LINE_NUMBER=0
    while read line; do
        ((LINE_NUMBER+=1))
        if [[ $line == "#### START - CUSTOM ENVIRONMENTAL VARIABLES" ]]; then
            START_LINE=$LINE_NUMBER
        fi
        if [[ $line == "#### END - CUSTOM ENVIRONMENTAL VARIABLES" ]]; then
            END_LINE=$LINE_NUMBER
        fi
    done < $FAKE_BASHRC
}


# Delete previously set Custom Environmental Variables 
find_line_numbers
