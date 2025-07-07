_: let
  btrfsMountOptions = ["compress=zstd:2" "ssd" "noatime" "discard=async" "space_cache=v2"];
in {
  boot.initrd.luks.devices."root".device = "/dev/disk/by-uuid/8bf50371-6bef-4c67-917e-a641e5a2f306";
  boot.initrd.luks.devices."swap".device = "/dev/disk/by-uuid/eb961ad9-898c-4b2c-a088-cce70a864a55";

  fileSystems = {
    "/" = {
      device = "none";
      fsType = "tmpfs";
      options = ["size=8G" "mode=755"];
    };

    "/home" = {
      device = "/dev/disk/by-uuid/4bd2f78b-962d-4af9-b26c-804a53255a0b";
      fsType = "btrfs";
      options = btrfsMountOptions ++ ["subvol=@home"];
    };

    "/nix" = {
      device = "/dev/disk/by-uuid/4bd2f78b-962d-4af9-b26c-804a53255a0b";
      fsType = "btrfs";
      options = btrfsMountOptions ++ ["subvol=@nix"];
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/A010-F006";
      fsType = "vfat";
      options = ["fmask=0022" "dmask=0022"];
    };
  };

  swapDevices = [
    {device = "/dev/disk/by-uuid/99ee3ab5-6948-4a8d-9032-6f7815d81683";}
  ];
}
