#!/bin/bash
#
# Developer contact: taksjosephrefugio@gmail.com
#


####################
# GLOBAL VARIABLES #
####################
BASHRC="$HOME/Downloads/fake_bashrc"
PROJECTDIR=""
CUSTOMVARSFILE=$HOME/.custom_env_vars

START_DELIMETER="#### SETTING PERSONALIZED ENVIRONMENTAL VARIABLES"
END_DELIMETER="#### END OF SETTING PERSONALIZED ENVIRONMENTAL VARIABLES"


###################
# HELPER METHODS  #
###################

# Find out project's base directory location
get_project_dir_location() {
    # Keep going up the directory tree until we hit project's base directory
    while [[ $(basename $(pwd)) != "GramDemolition" ]]; do pushd .. >/dev/null ; done

    # Save project's directory location
    retval=$(pwd)

    # Return to stack bottom
    pushd -0 >/dev/null

    # Clear directory stack
    dirs -c

    # Echo to return
    echo $retval
}


# Parse the contents of the environmental variables file
get_env_vars() {
    # Go through each line in env_vars
    while read line; do
        KEY=${line%=*}
        VALUE=${line#*=}
        echo $KEY
        echo $VALUE
    done < "$PROJECTDIR/env_vars"
}


# This function finds the starting and ending delimeters for custom environmental variables, if they exist at all. 
get_env_vars_section_in_bashrc() {
    local LINE_NUMBER=0
    local START_LINE=0
    local END_LINE=0
    while read line; do
        ((LINE_NUMBER+=1))
        if [[ $line == $START_DELIMETER ]]; then START_LINE=$LINE_NUMBER; fi
        if [[ $line == $END_DELIMETER ]]; then END_LINE=$LINE_NUMBER; fi
    done < $BASHRC
    
    echo $START_LINE $END_LINE
}


# This function adds an 'export' line on $HOME bashrc so it can read custom environmental variables written on $HOME/.custom_env_vars
add_env_vars() {
    local START_LINE=$1
    local END_LINE=$2
    local COMMAND=$(echo 'export $(grep -v "^#" {} | xargs -d "\n")' | sed 's|{}|'"$CUSTOMVARSFILE"'|g')

    # Send custom env vars file to $HOME
    cp $PROJECTDIR/dotfiles/custom_env_vars $CUSTOMVARSFILE && echo ">>> Custom environmental variables file sent to $HOME"

    # Insert space if no new endline found on bashrc
    if [[ ! -z $(tail -c 1 $BASHRC) ]]; then echo >> $BASHRC; fi

    echo >> $BASHRC
    echo $START_DELIMETER >> $BASHRC
    echo $COMMAND >> $BASHRC
    echo $END_DELIMETER >> $BASHRC
}


#############
#  M A I N  #
#############
start() {
    PROJECTDIR=$(get_project_dir_location)

    read START_LINE END_LINE < <(get_env_vars_section_in_bashrc)

    if [[ $START_LINE -eq 0 ]]; then
        # For when .bashrc contains NO existing custom environmental variables
        add_env_vars && echo ">>> Custom environmental variables have been set successfully!"
    else
        # For when .bashrc contains existing custom environmental variables
        echo ">>> Custom environmental variables already being set at Line $START_LINE"
        exit 1
    fi
}


case "$1" in
  start)
    start
    ;;
  clean|undo)
    rm -v $CUSTOMVARSFILE
    ;;
  *)
    echo "Usage: $0 {start|clean|undo}"
esac
