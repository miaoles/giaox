(use-modules
  (gnu home)
  (gnu packages)
  (gnu services)
  (guix gexp)
  (gnu home services)
  (gnu home services shells)
  (giaox packages chatterino2))

(home-environment
  (packages (specifications->packages (list
    "chatterino2")))
  (services (list
    (service home-bash-service-type
      (home-bash-configuration
        (aliases '(
          ("grep" . "grep --color=auto")
          ("ll" . "ls -l")
          ("ls" . "ls -p --color=auto")))
        (bashrc (list (local-file
          "../configurations/bash/.bashrc" "bashrc")))
        (bash-profile (list (local-file
          "../configurations/bash/.bash_profile" "bash_profile")))))
    (service home-files-service-type `(
      (".config/guix/channels.scm" ,(local-file "../channels/channels.scm" #:recursive? #true))
      (".config/bspwm" ,(local-file "../configurations/bspwm" #:recursive? #true))
      (".config/sxhkd" ,(local-file "../configurations/sxhkd" #:recursive? #true)))))))
