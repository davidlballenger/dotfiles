#!/usr/bin/env bash


export dotfiles=$HOME/.dotfiles
export DOTFILES=$dotfiles

link_files() {
    source=$1
    target=$2
    current_target=""

    echo "link_files: Ensure \"${target}\"  -> \"${source}\""
    if [[ -L "${target}" ]]; then
        current_source=$(readlink "${target}")
        echo "link_files: current_source=$current_source"
    fi
    if [[ "${source}" == "${current_source}" ]]; then
        echo "link_files: Already linked \"${target}\"  -> \"${source}\""
    else
        if [[ -a "${target}" ]] ; then
            echo "link_files: \"${target}\" exists but is not a link to \"${source}\""
            echo "link_files: saving \"{target}\" as \"${target}.save\""
            mv "${target}" "${target}.save"
        fi
        echo "link_files: Creating link \"${target}\"  -> \"${source}\""
        ln -s "${source}" "${target}"
    fi
}


echo "Setup $DOTFILES"

my_setup_files=($DOTFILES/*/setup.sh)

for f in ${my_setup_files[@]};   do 
  echo "Setup file: ${f}"
  source $f
done

