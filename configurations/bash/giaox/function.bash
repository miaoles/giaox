#!/bin/bash

REPO_ROOT="~/Development/giaox"

function giaox() {
  function update() {
    echo "Running guix pull..."
    guix pull
  }

  function system_reconfigure() {
    echo "Reconfiguring system..."
    sudo guix system reconfigure "$REPO_ROOT/system/main.scm"
  }

  function home_reconfigure() {
    echo "Reconfiguring home..."
    guix home reconfigure "$REPO_ROOT/home/main.scm"
  }

  case "$1" in
    upgrade)
      case "$2" in
        system)
          update
          system_reconfigure
          ;;
        home)
          update
          home_reconfigure
          ;;
        both|"")
          update
          system_reconfigure
          home_reconfigure
          ;;
        *)
          echo "Invalid option: $2"
          echo "Usage: giaox upgrade [system|home|both]"
          ;;
      esac
      ;;
    reconfigure)
      case "$2" in
        system)
          system_reconfigure
          ;;
        home)
          home_reconfigure
          ;;
        both|"")
          system_reconfigure
          home_reconfigure
          ;;
        *)
          echo "Invalid option: $2"
          echo "Usage: giaox reconfigure [system|home|both]"
          ;;
      esac
      ;;
    *)
      echo "Usage: giaox <command> [options]"
      echo "Available commands:"
      echo "  upgrade       Upgrade system, home, or both"
      echo "  reconfigure   Reconfigure system, home, or both"
      ;;
  esac
}
