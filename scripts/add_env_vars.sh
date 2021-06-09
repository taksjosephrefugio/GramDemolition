#!/bin/bash
#
# Developer contact: taksjosephrefugio@gmail.com
#


####################
# GLOBAL VARIABLES #
####################
FAKE_BASHRC="$HOME/Downloads/nfake_bashrc"
PROJECTDIR=""


# Find out project's base directory location
get_project_dir_location() {
    # Keep going up the directory tree until we hit project's base directory
    while [[ $(basename $(pwd)) != "GramDemolition" ]]; do pushd .. >/dev/null ; done

    # Save project's directory location
    PROJECTDIR=$(pwd)

    # Return to stack bottom
    pushd -0 >/dev/null

    # Clear directory stack
    dirs -c
}


# Parse the contents of the environmental variables file
read_env_vars() {
    # Go through each line in env_vars
    while read line; do
        KEY=${line%=*}
        VALUE=${line#*=}
        echo $KEY
        echo $VALUE
    done < "$PROJECTDIR/env_vars"
}


# Find line numbers of previously set Custom Environmental Variables
find_env_vars_section() {
    LINE_NUMBER=0
    while read line; do
        ((LINE_NUMBER+=1))
        if [[ $line == "#### START - CUSTOM ENVIRONMENTAL VARIABLES" ]]; then START_LINE=$LINE_NUMBER; fi
        if [[ $line == "#### END - CUSTOM ENVIRONMENTAL VARIABLES" ]]; then END_LINE=$LINE_NUMBER; fi
    done < $FAKE_BASHRC
}


#############
#  M A I N  #
#############
