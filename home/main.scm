(use-modules
  (gnu home)
  (gnu packages)
  (gnu services)
  (guix gexp)
  (gnu home services)
  (gnu home services shells))

(home-environment
  (packages (specifications->packages (list
    "chatterino2"
    "nicotine+"
    "qbittorrent"
    "obs")))
  (services (list
    (service home-bash-service-type
      (home-bash-configuration
        (aliases '(
          ("grep" . "grep --color=auto")
          ("ll" . "ls -l")
          ("ls" . "ls -p --color=auto")))
        (bashrc (list
          (local-file "../configurations/bash/.bashrc" "bashrc")
          (local-file "../configurations/bash/shell-options.bash" "bashrc")
          (local-file "../configurations/bash/prompt.bash" "bashrc")
          (local-file "../configurations/bash/giaox/function.bash" "bashrc")))
        (bash-profile (list
          (local-file "../configurations/bash/.bash_profile" "bash_profile")
          (local-file "../configurations/bash/giaox/completions.bash" "bash_profile")))))
    (service home-files-service-type `(
      (".config/guix/channels.scm" ,(local-file "../channels/channels.scm" #:recursive? #true))
      (".Xresources" ,(local-file "../configurations/x11/Xresources" #:recursive? #true))
      (".config/picom" ,(local-file "../configurations/picom" #:recursive? #true))
      (".config/bspwm" ,(local-file "../configurations/bspwm" #:recursive? #true))
      (".config/sxhkd" ,(local-file "../configurations/sxhkd" #:recursive? #true))
      (".config/tint2" ,(local-file "../configurations/tint2" #:recursive? #true))
      (".config/qterminal.org" ,(local-file "../configurations/qterminal" #:recursive? #true))
      (".local/share/chatterino/Settings" ,(local-file "../configurations/chatterino2" #:recursive? #true)))))))
