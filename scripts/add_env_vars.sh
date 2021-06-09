#!/bin/bash
#
# Developer contact: taksjosephrefugio@gmail.com
#


####################
# GLOBAL VARIABLES #
####################
BASHRC="$HOME/Downloads/fake_bashrc"
PROJECTDIR=""

DELIM_START="#### START - CUSTOM ENVIRONMENTAL VARIABLES"
DELIM_END="#### END - CUSTOM ENVIRONMENTAL VARIABLES"



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
get_env_vars() {
    # Go through each line in env_vars
    while read line; do
        KEY=${line%=*}
        VALUE=${line#*=}
        echo $KEY
        echo $VALUE
    done < "$PROJECTDIR/env_vars"
}


# Find line numbers of previously set Custom Environmental Variables
get_env_vars_section_in_bashrc() {
    LINE_NUMBER=0
    while read line; do
        ((LINE_NUMBER+=1))
        if [[ $line == $DELIM_START ]]; then START_LINE=$LINE_NUMBER; fi
        if [[ $line == $DELIM_END ]]; then END_LINE=$LINE_NUMBER; fi
    done < $BASHRC
}


add_env_vars() {

    insert_env_vars_section() {
        echo >> $BASHRC
        echo $DELIM_START >> $BASHRC
        cat "$PROJECTDIR/env_vars" >> $BASHRC
        echo >> $BASHRC
        echo $DELIM_END >> $BASHRC
    }

    if [[ ! -z $(tail -c 1 $BASHRC) ]]; then echo >> $BASHRC; fi
    insert_env_vars_section
}


#############
#  M A I N  #
#############
get_project_dir_location
get_env_vars_section_in_bashrc


if [[ $START_LINE -eq 0 ]]; then
    # For when .bashrc contains NO existing custom environmental variables
    add_env_vars
else
    # TODO: For when .bashrc contains existing custom environmental variables 
    echo "Theres something there already"
    echo $START_LINE
    echo $END_LINE
fi
