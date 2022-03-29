lsblk - list block devices (hdds, usb sticks, etc)

```lsblk```

write iso to usb stick
```
dd bs=4M if=Downloads/Qubes-R4.1.0-x86_64/Qubes-R4.1.0-x86_64.iso of=/dev/sdb conv=fdatasync
```
