(use-modules
    (gnu)
    (gnu system nss))

(define hardware-bootloader
  (bootloader-configuration
    (bootloader grub-bootloader)
    (targets (list "/dev/nvme0n1"))
    (keyboard-layout  (keyboard-layout "us"))))

(define hardware-swap-devices
  (list (swap-space
    (target (uuid "0ec85359-8b24-493f-afb6-f15c66a29e15")))))

(define hardware-file-systems
  (cons*
    (file-system
      (mount-point "/")
      (device (uuid "afa39dd2-d41d-4da2-9682-97a79543ce52" 'ext4))
      (type "ext4"))
    ;;(file-system
    ;;  (mount-point "/boot/efi")
    ;;  (device (uuid "D8F7-8375" 'fat32))
    ;;  (type "vfat"))
    %base-file-systems))
