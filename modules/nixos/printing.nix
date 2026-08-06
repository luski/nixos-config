{
  services = {
    # avahi – for automatic printer discovery
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
    printing = {
      enable = true;
    };
  };
}
