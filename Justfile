
make:
    cargo build --target aarch64-unknown-uefi

qemudir := `ls /opt/homebrew/Cellar/qemu | head -n 1`
run:
    mkdir -p target/efi/EFI/BOOT
    cp target/aarch64-unknown-uefi/debug/rust-uefi-practice.efi target/efi/EFI/BOOT/BOOTAA64.EFI
    qemu-system-aarch64 -bios "/opt/homebrew/Cellar/qemu/"{{qemudir}}"/share/qemu/edk2-aarch64-code.fd" -machine virt,highmem=off -accel hvf -m 1G -cpu cortex-a72 -nodefaults -device ramfb -drive format=raw,file=fat:rw:target/efi