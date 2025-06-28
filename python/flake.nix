{
  description = "Python development environment with Nix flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      utils,
    }:
    utils.lib.eachSystem [ "x86_64-linux" "aarch64-linux" ] (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
        python = pkgs.python310;
        pythonPackages = python.pkgs;

        inherit (nixpkgs) lib;
        runtimeDependencies = with pkgs; [

        ];

        nativeBuildInputs = with pkgs; [
          bashInteractive
        ];

        buildInputs = with pythonPackages; [
            pkgs.nodePackages.pyright
            pkgs.poetry
            setuptools
            wheel
            venvShellHook
          ];

      in
      {
        devShells.default = pkgs.mkShell {
          name = "python-devshell";
          inherit buildInputs nativeBuildInputs runtimeDependencies;

          # venvDir = ".venv";

          # src = null;

          # postVenv = ''
          #   unset SOURCE_DATE_EPOCH
          # '';

          # postShellHook = ''
          #   unset SOURCE_DATE_EPOCH
          #   unset LD_PRELOAD

          #   PYTHONPATH=$PWD/$venvDir/${python.sitePackages}:$PYTHONPATH
          # '';

          LD_LIBRARY_PATH = lib.makeLibraryPath (buildInputs ++ nativeBuildInputs ++ runtimeDependencies);
        };
      }
    );
}
