# NixOS configuration

## Rebuild the system

Run from the repository root:

```bash
sudo nixos-rebuild switch --flake .#nixos-boxes
```

## Desktop sessions

Enable or disable login sessions in `hosts/boxes/default.nix`:

```nix
desktopSessions = {
  cosmic.enable = true;
  hyprland.enable = true;
  niri.enable = true;
};
```

Disabled sessions remain configured in the repository but are not installed.
At least one session must be enabled.
