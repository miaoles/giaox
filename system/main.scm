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

(load "../hosts/desktop/hardware.scm")

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
    (cons*
      (user-account
        (name main-user-name)
        (comment main-user-name)
        (group "users")
        (home-directory (string-append "/home/" main-user-name))
        (supplementary-groups '("wheel" "netdev" "audio" "video")))
    %base-user-accounts))

  (packages
    (append (map specification->package '(
      "ncurses" ;; tput
      "xrandr"
      "bspwm"
      "sxhkd"
      "xdg-desktop-portal"
      "lximage-qt"
      "bluez"
      "bluez-alsa"
      "blueman"
      "font-google-roboto"
      "font-google-roboto-mono"
      "font-google-noto"
      "font-google-noto-emoji"
      "font-google-noto-sans-cjk"
      "breeze-icons"
      "bibata-cursor-theme"
      "xscreensaver"
      "tint2"
      "xtitle"
      "kvantum"
      "nm-tray"
      "copyq"
      "ntfs-3g"
      "lxqt-archiver"
      "unrar"
      "unzip"
      "p7zip"
      "libexif"
      "v4l-utils"
      "xdotool"
      "patchutils"
      "i2c-tools"
      "ffmpeg"
      "yt-dlp"
      "emacs"
      "kate"
      "git"
      "firefox"
      "ungoogled-chromium"
      "steam"
      "protonup-ng"))
    %base-packages))

  (services
    (cons*
;;    (service network-manager-service-type)
      (service bluetooth-service-type)
      (service cups-service-type)
;;    (service spice-vdagent-service-type)
      (set-xorg-configuration (xorg-configuration (keyboard-layout keyboard-layout)))
      (service lxqt-desktop-service-type)
    desktop-services-revised)))
