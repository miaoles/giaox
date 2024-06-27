(use-modules
    (gnu)
    (gnu system nss))

(define hardware-bootloader
  (bootloader-configuration
    (bootloader grub-bootloader)
    (targets (list "/dev/sda"))
    (keyboard-layout  (keyboard-layout "us"))))

(define hardware-swap-devices
  (list (swap-space
    (target (uuid "2909d033-95d0-4f73-9a75-6ab64abe4467")))))

(define hardware-file-systems
  (cons*
    (file-system
      (mount-point "/")
      (device (uuid "6bf2439e-74b9-4f3b-8540-e8cbf91a1c8a" 'ext4))
      (type "ext4"))
    (file-system
      (mount-point "/home")
      (device (uuid "3abe63c1-5da9-45f0-baba-3c841d6af28f" 'ext4))
      (type "ext4"))
    %base-file-systems))
