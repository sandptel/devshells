{
  description = "Regolith NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    #distro-grub-themes.url = "github:AdisonCavani/distro-grub-themes";
    regolith.url = "github:regolith-lab/regolith-nix";
  };

  outputs =
    inputs@{ self, nixpkgs, ... }:
    let
      system = "x86_64-linux";
      host = "regolith";
      username = "roronoa";

      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };
      };
    in
    {
      templates.rust-minimal = {
        path = ./rust/minimal; 
        description = "Minimal Rust Development Environment";
        welcomeText = ''
          Welcome to the Rust development environment!
        '';
      };

      templates.rust-full = {
        path = ./rust/full; 
        description = "Full Rust Development Environment";
        welcomeText = ''
          Welcome to the full Rust development environment!
        '';
      };

      templates.python = {
        path = ./python; 
        description = "Python Development Environment";
        welcomeText = ''
          Welcome to the Python development environment!
        '';
      };

      templates.default = self.templates.rust;
    };

}
