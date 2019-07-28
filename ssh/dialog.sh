# /bin/bash

#declare -a AVAILABLE_OPTIONS
declare -a ENVIRONMENTS
ENVIRONMENTS=($(ls $HOME/.lazy_ssh/))
#AVAILABLE_OPTIONS=(Add Edit Delete)
program_stage=0

function server_select {
    while IFS= read -r line; do
        DIALOG_STRING_SERVER="$DIALOG_STRING_SERVER "$line" |"
    done < "$HOME/.lazy_ssh/$1"
    SSH_SERVER=$(dialog --stdout --menu "select option" 20 100 50 $DIALOG_STRING_SERVER)
    clear
    ssh root@$SSH_SERVER
}

function select_environment {
    for env in "${ENVIRONMENTS[@]}"
    do
        DIALOG_STRING_ENV="$DIALOG_STRING_ENV $env |"
    done
    SSH_ENVIRONMENT=$(dialog --stdout --menu "select option" 20 100 50 $DIALOG_STRING_ENV)
    echo "$SSH_ENVIRONMENT"
    server_select $SSH_ENVIRONMENT
}

select_environment
