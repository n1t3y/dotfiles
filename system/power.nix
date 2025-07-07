{lib, ...}: {
  services.logind = {
    lidSwitch = "poweroff";
    lidSwitchExternalPower = "lock";
    lidSwitchDocked = "ignore";
  };

  powerManagement = {
    enable = true;
    powertop.enable = true;
    cpuFreqGovernor = lib.mkDefault "powersave";
  };
  services.thermald.enable = true;
}
