(use-modules
  (gnu)
  (gnu packages)
  (nongnu packages linux)
  (nongnu system linux-initrd)
  (gnu services)
  (gnu services desktop))

(use-service-modules cups desktop networking ssh xorg spice)

(load "../devices/vitual-machine/hardware.scm")

(define main-user-name "miles")
(define main-host-name "iao")
(define main-time-zone "America/New_York")

(define desktop-services-revised
  (modify-services %desktop-services
    (guix-service-type service =>
      (guix-configuration
        (inherit service)
        (substitute-urls
          (append (list "https://substitutes.nonguix.org")
          %default-substitute-urls))
        (authorized-keys
          (append (list (local-file "./channels/nonguix/signing-key.pub"))
          %default-authorized-guix-keys))))))

(operating-system
  (locale "en_US.utf8")
  (timezone main-time-zone)
  (keyboard-layout (keyboard-layout "us"))
  (host-name main-host-name)
  (kernel linux)
  (initrd microcode-initrd)
  (firmware (list linux-firmware))
  (inherit hardware-configuration)

  (users
    (cons* (user-account
      (name main-user-name)
      (comment main-user-name)
      (group "users")
      (home-directory (string-append "/home/" main-user-name))
      (supplementary-groups '("wheel" "netdev" "audio" "video")))
    %base-user-accounts))

  (packages
    (append (map specification->package
      '("bspwm"
      "sxhkd"
      "tint2"
      "kvantum"
      "nm-tray"
      "emacs"
      "kate"
      "git"
      "firefox"
      "steam"
      "protonup-ng"))
    %base-packages))

  (services
    (append (list
;;    (service network-manager-service-type)
      (service lxqt-desktop-service-type)
      (service cups-service-type)
      (service spice-vdagent-service-type)
      (set-xorg-configuration
        (xorg-configuration (keyboard-layout keyboard-layout))))
    desktop-services-revised)))
