{
  config,
  lib,
  pkgs,
  ...
}: {
  meta = {};

  imports = [];

  options = {};

  config = {
    environment.systemPackages = with pkgs; [
      # coreboot toolchain for riscv targets
      coreboot-toolchain.riscv

      # ecosystem for IoT development
      # https://docs.platformio.org/en/latest/integration/ide/vscode.html
      # platformio

      # machine & userspace emulator and virtualizer
      qemu

      # graphical processor simulator and assembly editor for the RISC-V ISA
      # https://github.com/mortbopet/Ripes
      ripes
    ];
  };
}
