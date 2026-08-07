# NixOS configuration

## Rebuild the system

Run from the repository root:

```bash
sudo nixos-rebuild switch --flake .#nixos-boxes
```

## TODO

- Move the custom Elephant bookmarks module (`menus/bookmarks.lua`) into this configuration and manage `BOOKMARKS_PATH` declaratively.
