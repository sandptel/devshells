{
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, flake-utils, nixpkgs }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        inherit (nixpkgs) lib;
        pkgs = nixpkgs.legacyPackages.${system};
        rpath = lib.makeLibraryPath (with pkgs; [
          # openssl
          # libressl
        ]);
      in
      {
        devShells.default = pkgs.mkShell {

          nativeBuildInputs = with pkgs; [
            # rustc
            # cargo
            # pkg-config
          ];

          # buildInputs = with pkgs; [
          #   openssl
          #   # libressl
          # ];

          # defines the environment variables
          OPENSSL_DIR= lib.makeLibraryPath (with pkgs; [  
            # openssl 
            ]);
        
          # shellHook = ''
          #   export OPENSSL_DIR=${pkgs.openssl}
          #   '';

          # links the library path dynamically to the shell
          LD_LIBRARY_PATH = rpath;
        };
      }
    );
}
