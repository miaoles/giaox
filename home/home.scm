(use-modules (gnu home)
             (gnu packages)
             (gnu services)
             (guix gexp)
             (gnu home services)
             (gnu home services shells)
             (chatterino2 chatterino2))  ; Added this line

(home-environment
  ;; Below is the list of packages that will show up in your
  ;; Home profile, under ~/.guix-home/profile.
  (packages (specifications->packages (list "chatterino2")))  ; Modified this line

  ;; Below is the list of Home services.  To search for available
  ;; services, run 'guix home search KEYWORD' in a terminal.
  (services (list

    (service home-bash-service-type
      (home-bash-configuration
        (aliases '(
          ("grep" . "grep --color=auto")
          ("ll" . "ls -l")
          ("ls" . "ls -p --color=auto")))
        (bashrc (list (local-file
          "/home/miles/Development/giaox/home//.bashrc"
          "bashrc")))
        (bash-profile (list (local-file
          "/home/miles/Development/giaox/home//.bash_profile"
          "bash_profile")))))

    (service home-files-service-type
      `((".config/bspwm" ,(local-file "../configurations/bspwm" #:recursive? #true))
        (".config/sxhkd" ,(local-file "../configurations/sxhkd" #:recursive? #true)))))))
