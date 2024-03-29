#!/bin/bash

if which mplayer 1>/dev/null 2>&1; then
    export CACA_DRIVER=ncurses
    PK_EXECUTE="mplayer -really-quiet -vo caca"
else
    echo "Error: mplayer is required. Make sure it's installed, and on your PATH."
    exit -1
fi

# ALL_JEFFS_GADGETS="$(ls jeffs-gadgets)"

get_random_psi_attack() {
    NUM_PSI_ATTACKS=$(ls psi-attacks | wc -l)
    NUM_JEFFS_GADGETS=$(ls jeffs-gadgets | wc -l)
    NUM_POSSIBILITIES=$NUM_PSI_ATTACKS
    let "NUM_POSSIBILITIES += $NUM_JEFFS_GADGETS"
    psi_choice=$RANDOM
    let "psi_choice %= $NUM_POSSIBILITIES"
    if [[ $psi_choice -ge $NUM_PSI_ATTACKS ]]; then
        # It's one of Jeff's gadgets
        let "psi_choice %= $NUM_JEFFS_GADGETS"
        search_dir="jeffs-gadgets"
    else
        # It's a PSI attack
        search_dir="psi-attacks"
    fi
    i=0
    for attack in $(ls $search_dir); do
        if [[ $i == $psi_choice ]]; then
            psi_choice="$search_dir/$attack"
            break
        else
            i=$(expr $i + 1)
        fi
    done
}

get_random_psi_attack_variant() {
    NUM_PSI_ATTACK_VARIANTS=$(ls "$1" | wc -l)
    variant_choice=$RANDOM
    let "variant_choice %= $NUM_PSI_ATTACK_VARIANTS"
    i=0
    for variant in $(ls "$1"); do
        if [[ $i == $variant_choice ]]; then
            psi_choice_variant=$variant
            break
        else
            i=$(expr $i + 1)
        fi
    done
}

error() {
    echo "$1"
    exit -1
}

if [[ $# == 0 ]]; then
    get_random_psi_attack  # reads into 'psi_choice'
    if [[ $psi_choice =~ "jeffs-gadgets" ]]; then
        $PK_EXECUTE "$psi_choice"
    else
        get_random_psi_attack_variant $psi_choice # reads into 'psi_attack_variant'
        $PK_EXECUTE "$psi_choice/$psi_choice_variant"
    fi
elif [[ $# -ge 1 ]]; then
    psi_attack="$1"
    ALL_PSI_ATTACKS="$(ls psi-attacks)"
    ALL_JEFFS_GADGETS="$(ls jeffs-gadgets)"
    if [[ "$ALL_PSI_ATTACKS" =~ "$psi_attack" ]]; then
        if [[ $# == 1 ]]; then
            get_random_psi_attack_variant psi-attacks/$psi_attack
        else
            ALL_ATTACK_VARIANTS=$(ls psi-attacks/$psi_attack)
            if [[ "$ALL_ATTACK_VARIANTS" =~ "$2.webm" ]]; then
                psi_choice_variant="$2.webm"
            else
                error "Error: '$psi_attack' has no '$2' variant."
            fi
        fi
        $PK_EXECUTE "psi-attacks/$psi_attack/$psi_choice_variant"
    elif [[ "$ALL_JEFFS_GADGETS" =~ "$psi_attack" ]]; then
        $PK_EXECUTE "jeffs-gadgets/$psi_attack.webm"
    else
        error "Error: '$1' is not a known PSi attack."
    fi
fi

