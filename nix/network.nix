{ lib, ... }:
{
  networking =
    let
      replacedLastOctet =
        ip: newOctet:
        let
          parts = lib.splitString "." ip;
          start = lib.take 3 parts;
          final = lib.concatStringsSep "." (start ++ [ newOctet ]);
        in
        final;
     makeSubnet = ip: prefixLength: {
        wildcard = replacedLastOctet ip "*";
        prefixLength = prefixLength;
        ip = ip;
        cidr = "${ip}/${builtins.toString prefixLength}";
        gateway = replacedLastOctet ip "1";
          ssh = 22;
        # The first three octets of the IP address
        triplet = lib.concatStringsSep "." (lib.take 3 (lib.splitString "." ip));
      };

      # Return a set of host attrs
      makeHost = name: ip: mac: user: {
        ${name} = {
            inherit name ip mac user;
        };
      };
      defaultUser = "";
      emptyMac = "";
    in
    rec {
      #
      # ========== Subnets ========== 
      #
      subnets = {
        subnetname = (makeSubnet "10.10.10.0" 24) // {
          hosts = lib.mergeAttrsList [
             (makeHost "hostname1" "10.10.10.1" emptyMac defaultUser)
             (makeHost "hostname2" "10.10.10.2" "00:00:00:00:00" "hiro")
          ];
        };
        anothersubnetname = (makeSubnet "10.10.20.0" 24) // {
          hosts = lib.mergeAttrsList [
             (makeHost "hostname3" "10.10.20.1" "00:00:00:00:01" defaultUser)
          ];
        };
      };

      #
      # ========== Private DNS/host entries ========== 
      #
      work.hosts = {
        "0.0.0.0" = [ "foo.bar.com" ];
      };

      # Ports used for services
      ports = {
        tcp = {
          ssh = 22;
       };
        udp = {
       };
      };

      # These can be used declaring for granular firewall entries
      rules =
        with subnets.subnetname;
        {
         hostname1 = {
            sshAllowedHosts = [
                hostname1
                hostname2
            ];
          };
        };
      #
      # ========== ssh entries ========== 
      #
      ssh = {
        yubikeyHostsWithDomain = [ ]; # hostnames I want private, that use my domain
        yubikeyHosts = [ ]; # hostnames outside of my domain
        forwardAgentUntrusted = [ ]; # domainHosts entries that I don't trust to use agent forwarding
        matchBlocks = lib: {
          "somehostname" = lib.hm.dag.entryAfter [ "*" ] {
            host = "somehostname";
            hostname = "0.0.0.0";
            user = "hiro";
            localForwards = [
              {
                bind.address = "localhost";
                bind.port = 1111;
                host.address = "localhost";
                host.port = 1111;
              }
            ];
          };
        };
     };
  };
}

