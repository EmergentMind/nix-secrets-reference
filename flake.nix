{
  description = "Reference example of EmergentMind's nix-secrets flake - complex variant";
  outputs =
    { nixpkgs, ... }:
    let
      lib = nixpkgs.lib;
      forAllSystems = nixpkgs.lib.genAttrs [
        "x86_64-linux"
        "aarch64-darwin"
      ];
      nixFiles = builtins.map (name: import ./nix/${name} { inherit lib; }) (
        builtins.attrNames (builtins.readDir ./nix)
      );
    in
    (lib.foldl lib.recursiveUpdate { } nixFiles)
    // {
      devShells = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          default = pkgs.mkShell {
            packages = with pkgs; [
              sops

              # fix https://discourse.nixos.org/t/non-interactive-bash-errors-from-flake-nix-mkshell/33310
              bashInteractive
              deadnix
              nixfmt-rfc-style
              pre-commit
            ];
          };
        }
      );
    };
}
