# devshells
```nix
{
  description = "Development shell for building and testing a applications for cosmic desktop environment";
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, flake-utils, nixpkgs }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        inherit (nixpkgs) lib;
        pkgs = nixpkgs.legacyPackages.${system};
        # rpath = lib.makeLibraryPath (with pkgs; [
        #   openssl
        #   # libressl
        # ]);
        nativeBuildInputs = with pkgs; [ just pkg-config autoPatchelfHook ];
          buildInputs = with pkgs; [
            openssl
            libxkbcommon
            glib # For gobject
            libglvnd # For libEGL
            libpulseaudio
            dbus.dev
            wayland
            libglvnd
          ];
      in
      {
        devShells.default = pkgs.mkShell {

          inherit buildInputs nativeBuildInputs;

          shellHook = ''
            export XDG_RUNTIME_DIR=${pkgs.xdg-desktop-portal}
          '';
          LD_LIBRARY_PATH = lib.makeLibraryPath (buildInputs ++ nativeBuildInputs);
        };
      }
    );
}
```




```nix
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
          openssl
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

          buildInputs = with pkgs; [
            openssl
          #   # libressl
          ];

          # defines the environment variables
          X86_64_UNKNOWN_LINUX_GNU_OPENSSL_LIB_DIR = lib.makeLibraryPath (with pkgs; [
            openssl
          ]);

          OPENSSL_INCLUDE_DIR = "${pkgs.openssl.dev}/include";
          OPENSSL_LIB_DIR = "${pkgs.openssl}/lib";


          # shellHook = ''
          #   export X86_64_UNKNOWN_LINUX_GNU_OPENSSL_DIR=${pkgs.openssl}
          #   '';

          # links the library path dynamically to the shell
          LD_LIBRARY_PATH = rpath;
        };
      }
    );
}
```
## Documentations 
### mkShell official Docs
https://nixos.org/manual/nixpkgs/stable/#sec-pkgs-mkShell

### Flake Parts with all flake realted docs
https://flake.parts

### Good Old Wiki
https://nixos.wiki/wiki/Flakes


# Python  
## - python-flake.nix 

> Implements python flake with automatic .venv implementation with pip install and stuff (flake is self explanatory)

## Devenv Implementation

https://devenv.sh/supported-languages/python/#languagespythonversion

### `languages.python.enable`
### `languages.python.poetry.enable`

### + .package siblings 

### `languages.python.libraries`  (probably not that thing)

Additional libraries to make available to the Python interpreter.

This is useful when you want to use Python wheels that depend on native libraries.

Type: list of path

Default: ` [ "${config.devenv.dotfile}/profile" ] `

Declared by: - https://github.com/cachix/devenv/blob/main/src/modules/languages/python.nix

### ` languages.python.venv.enable `

Whether to enable Python virtual environment.

Type: boolean

Default: false

Example: true

Declared by: - https://github.com/cachix/devenv/blob/main/src/modules/languages/python.nix

### `languages.python.venv.quiet`

Whether pip install should avoid outputting messages during devenv initialisation.

Type: boolean

Default: false

Declared by: - https://github.com/cachix/devenv/blob/main/src/modules/languages/python.nix

### `languages.python.venv.requirements`

Contents of pip requirements.txt file. This is passed to pip install -r during devenv shell initialisation.

Type: null or strings concatenated with “\n” or path

Default: null

Declared by: - https://github.com/cachix/devenv/blob/main/src/modules/languages/python.nix

### `languages.python.version`

The Python version to use. This automatically sets the languages.python.package using nixpkgs-python.

Type: null or string

Default: null

Example: "3.11 or 3.11.2"

Declared by: - https://github.com/cachix/devenv/blob/main/src/modules/languages/python.nix
