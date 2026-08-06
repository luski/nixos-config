{ pkgs, ... }:

{
  services = {
    greetd = {
      enable = true;

      settings.default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --remember-user-session";
        user = "greeter";
      };
    };
  };

  # Allow tuigreet to remember the last user and selected session.
  systemd.tmpfiles.rules = [
    "d /var/cache/tuigreet 0755 greeter greeter -"
  ];
}
