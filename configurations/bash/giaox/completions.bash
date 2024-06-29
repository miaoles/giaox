#!/bin/bash

_giaox_completion() {
  local cur prev opts
  COMPREPLY=()
  cur="${COMP_WORDS[COMP_CWORD]}"
  prev="${COMP_WORDS[COMP_CWORD-1]}"
  opts="upgrade reconfigure"

  case "${prev}" in
    upgrade|reconfigure)
      COMPREPLY=($(compgen -W "system home both" -- "${cur}"))
      return 0
      ;;
  esac

  COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
}

complete -F _giaox_completion giaox
