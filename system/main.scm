(use-modules
  (gnu)
  (gnu packages)
  (nongnu packages linux)
  (nongnu system linux-initrd)
  (gnu services)
  (gnu services base)
  (gnu services desktop)
  (guix gexp))

(use-service-modules cups desktop networking ssh xorg spice)

(load "../hosts/virtual-machine/hardware.scm")

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
          (append (list (local-file "../channels/nonguix/signing-key.pub"))
          %default-authorized-guix-keys))))))

(operating-system
  (locale "en_US.utf8")
  (timezone main-time-zone)
  (keyboard-layout (keyboard-layout "us"))
  (host-name main-host-name)
  (kernel linux)
  (initrd microcode-initrd)
  (firmware (list linux-firmware))
  (bootloader hardware-bootloader)
  (swap-devices hardware-swap-devices)
  (file-systems hardware-file-systems)

  (users
    (cons* (user-account
      (name main-user-name)
      (comment main-user-name)
      (group "users")
      (home-directory (string-append "/home/" main-user-name))
      (supplementary-groups '("wheel" "netdev" "audio" "video")))
    %base-user-accounts))

  (packages
    (append (map specification->package '(
      "xrandr"
      "bspwm"
      "sxhkd"
      "tint2"
      "xtitle"
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
    (cons*
;;    (simple-service 'custom-etc-files etc-service-type `(
;;        ("bspwm/bspwmrc" ,(local-file "../configurations/bspwm/bspwmrc"))
;;        ("sxhkd/sxhkdrc" ,(local-file "../configurations/sxhkd/sxhkdrc"))))
;;    (service network-manager-service-type)
      (service lxqt-desktop-service-type)
      (service cups-service-type)
      (service spice-vdagent-service-type)
      (set-xorg-configuration
        (xorg-configuration (keyboard-layout keyboard-layout)))
    desktop-services-revised)))
