{ ... }:
{
  imports = [ ../wash-common.nix ];

  # Server-specific: add samba group
  users.users.wash.extraGroups = [
    "wheel"
    "networkmanager"
    "samba"
  ];
}
