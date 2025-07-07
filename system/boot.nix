{pkgs, ...}: {
  boot = {
    loader = {
      systemd-boot.enable = false;
      efi.canTouchEfiVariables = true;
    };
    lanzaboote = {
      enable = true;
      pkiBundle = "/var/lib/sbctl";
    };
    supportedFilesystems = ["btrfs"];
    kernelPackages = pkgs.linuxPackages_zen;
  };
}
