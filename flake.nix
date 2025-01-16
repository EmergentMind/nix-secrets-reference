{
  description = "Reference example of EmergentMind's nix-secrets flake - simple variant";

  outputs =
    { ... }: {
      # Define variables for sensitive information that doesn't need to be encrypted by sops
      # These will be accessible in nix-config as inputs.nix-secrets.<variable>
      domain = "domain.com";
      userFullName = "Hiro Protagonist";
      email = {
        user = "hiro@domain.com";
        work = "h.p@cosanostra.pizza";
        msmtp-host = "smtp.domain.com";
        notifier = "notifier@domain.com";
        backup = "logger@domain.com";
        gitHub = "foo@users.noreply.github.com";
        gitLab = "foo@users.noreply.gitlab.com";
      };

      #
      # ========== service secrets ========== 
      # 
      syncthing = {
        foo = "<data>";
      };

      #
      # ========== network secrets ========== 
      #
      networking = {
        subnets = {
          prefix = {
            lan = "10.10.10.";
            wifi = "10.10.11.";
          };
          hostname1 = {
            name = "hostname1" ;
            ip = "10.10.10.1";
            mac = "00:00:00:00:00:00";
          };
          hostname2 = {
            name = "hostname2" ;
            ip = "10.10.10.2";
            mac = "00:00:00:00:00:00";
          };
          hostname3 = {
            name = "hostname3" ;
            ip = "10.10.10.3";
            mac = "00:00:00:00:00:00";
            port = "42069";
          };
       };
        external = {
          servername1 = {
            name = "servername1";
            username = "foo";
            ip = "0.0.0.0";
            port = 1356;
            localForwardsPort = 8090;
          };
        };
        ports = {
          tcp = {
            ssh = 22;
          };
          udp =
            {
            };
        };
      };
    };
}
