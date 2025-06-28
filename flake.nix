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
          echo -e "\e[31m
    ╦═╗┬ ┬┌─┐┬    ╔╦╗┬┌┐┌┬┌┬┐┌─┐┬  
    ╠╦╝│ │└─┐├─┤   ║║║││││││││├─┤│  
    ╩╚═└─┘└─┘┴ ┴   ╩ ╩┴┘└┘┴┴ ┴┴ ┴┴─┘
          \e[0m"
          echo -e "\e[33mMinimal Rust development environment loaded!\e[0m"
        '';
      };

      templates.rust-full = {
        path = ./rust/full; 
        description = "Full Rust Development Environment";
        welcomeText = ''
          echo -e "\e[31m
    ╦═╗┬ ┬┌─┐┬    ╔═╗┬ ┬┬  ┬    
    ╠╦╝│ │└─┐├─┤   ╠╣ │ ││  │    
    ╩╚═└─┘└─┘┴ ┴   ╚  └─┘┴─┘┴─┘  
    ╔╦╗┌─┐┬  ┬  ╔═╗┌┐┌┬  ┬┬┬─┐┌─┐┌┐┌┌┬┐┌─┐┌┐┌┌┬┐
     ║║├┤ └┐┌┘  ║╣ │││└┐┌┘│├┬┘│ ││││││││├┤ │││ │ 
    ═╩╝└─┘ └┘   ╚═╝┘└┘ └┘ ┴┴└─└─┘┘└┘┴ ┴┴└─┘┘└┘ ┴ 
          \e[0m"
          echo -e "\e[33mFull Rust development environment with all tools loaded!\e[0m"
        '';
      };

      templates.standard = {
        path = ./standard; 
        description = "Standard Development Environment";
        welcomeText = ''
          echo -e "\e[34m
    ╔═╗┌┬┐┌─┐┌┐┌┌┬┐┌─┐┬─┐┌┬┐  
    ╚═╗ │ ├─┤│││ ││├─┤├┬┘ ││  
    ╚═╝ ┴ ┴ ┴┘└┘─┴┘┴ ┴┴└──┴┘  
    ╔╦╗┌─┐┬  ┬  ╔═╗┌┐┌┬  ┬┬┬─┐┌─┐┌┐┌┌┬┐┌─┐┌┐┌┌┬┐
     ║║├┤ └┐┌┘  ║╣ │││└┐┌┘│├┬┘│ ││││││││├┤ │││ │ 
    ═╩╝└─┘ └┘   ╚═╝┘└┘ └┘ ┴┴└─└─┘┘└┘┴ ┴┴└─┘┘└┘ ┴ 
          \e[0m"
          echo -e "\e[33mStandard development environment ready!\e[0m"
        '';
      };

      templates.python = {
        path = ./python; 
        description = "Python Development Environment";
        welcomeText = ''
          echo -e "\e[32m
    ╔═╗┬ ┬┌┬┐┬ ┬┌─┐┌┐┌  
    ╠═╝└┬┘ │ ├─┤│ ││││  
    ╩   ┴  ┴ ┴ ┴└─┘┘└┘  
    ╔╦╗┌─┐┬  ┬  ╔═╗┌┐┌┬  ┬┬┬─┐┌─┐┌┐┌┌┬┐┌─┐┌┐┌┌┬┐
     ║║├┤ └┐┌┘  ║╣ │││└┐┌┘│├┬┘│ ││││││││├┤ │││ │ 
    ═╩╝└─┘ └┘   ╚═╝┘└┘ └┘ ┴┴└─└─┘┘└┘┴ ┴┴└─┘┘└┘ ┴ 
          \e[0m"
          echo -e "\e[33mPython development environment with 🐍 power!\e[0m"
        '';
      };

      templates.default = self.templates.standard;
    };

}
