#!/bin/bash
#
# Developer contact: taksjosephrefugio@gmail.com
#


####################
# GLOBAL VARIABLES #
####################
BASHRC="$HOME/Downloads/fake_bashrc"
PROJECTDIR=""

START_DELIMETER="#### START - CUSTOM ENVIRONMENTAL VARIABLES"
END_DELIMETER="#### END - CUSTOM ENVIRONMENTAL VARIABLES"


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

