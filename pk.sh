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
    i=0
    for attack in $(ls psi-attacks); do
        psi_attacks[$i]=$attack
        i=$(expr $i + 1)
    done
    NUM_PSI_ATTACKS=$(ls psi-attacks | wc -l)
    psi_choice=$RANDOM
    let "psi_choice %= $NUM_PSI_ATTACKS"
    psi_attack=${psi_attacks[psi_choice]}
    echo $psi_choice
}

get_random_psi_attack_variant() {
    NUM_PSI_ATTACK_VARIANTS=$(ls "psi-attacks/$1" | wc -l)
    variant_choice=$RANDOM
    let "variant_choice %= $NUM_PSI_ATTACK_VARIANTS"
    i=0
    for variant in $(ls "psi-attacks/$1"); do
        attack_variants[$i]=$variant
        i=$(expr $i + 1)
    done
    psi_attack_variant=${attack_variants[variant_choice]}
}

error() {
    echo "$1"
    exit -1
}

if [[ $# == 0 ]]; then
    get_random_psi_attack  # reads into 'psi_attack'
    get_random_psi_attack_variant $psi_attack # reads into 'psi_attack_variant'
    echo "psi-attacks/$psi_attack/$psi_attack_variant"
elif [[ $# -ge 1 ]]; then
    psi_attack="$1"
    ALL_PSI_ATTACKS="$(ls psi-attacks)"
    if [[ "$ALL_PSI_ATTACKS" =~ "$psi_attack" ]]; then
        if [[ $# == 1 ]]; then
            get_random_psi_attack_variant $psi_attack
        else
            ALL_ATTACK_VARIANTS=$(ls psi-attacks/$psi_attack)
            echo $ALL_ATTACK_VARIANTS
            if [[ "$ALL_ATTACK_VARIANTS" =~ "$2.webm" ]]; then
                psi_attack_variant="$2.webm"
            else
                error "Error: '$psi_attack' has no '$2' variant."
            fi
        fi
    else
        error "Error: '$1' is not a known PSi attack."
    fi
fi

$PK_EXECUTE "psi-attacks/$psi_attack/$psi_attack_variant"
