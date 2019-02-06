#!/usr/bin/env bash

_pp2n() {
  local cur opts
  COMPREPLY=()
  if [ "$COMP_CWORD" == 1 ]
  then
    cur="${COMP_WORDS[COMP_CWORD]}"
    opts="$(ls "$PROJECTS")"
    opts="install build sources help bower-install"

    # shellcheck disable=2207
    COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
  fi
}

complete -F _pp2n pp2n
