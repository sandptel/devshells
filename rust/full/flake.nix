{
  description = "Minimal Rust development environment with Nix flake";

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
        inherit (nixpkgs) lib;
        runtimeDependencies = with pkgs; [
          # openssl # SSL runtime library
          # zlib # Compression library
          # # Add other runtime libraries your Rust app needs
        ];

        nativeBuildInputs = with pkgs; [
          # pkg-config # For finding system libraries
          # cmake # Build system (for some native deps)
          # openssl.dev # SSL development headers
        ];

        buildInputs = with pkgs; [
          cargo
          rustc
          rustfmt

          # # Additional Rust tools
          # clippy # Rust linter
          # rust-analyzer # Language server
          # rustup # Rust toolchain manager
          # cargo-watch # Auto-rebuild on file changes
          # cargo-edit # cargo add/rm/upgrade commands
          # cargo-audit # Security vulnerability scanner
          # cargo-deny # Dependency checker
          # cargo-outdated # Check for outdated dependencies

          # # Development tools
          # gdb # Debugger
          # valgrind # Memory debugger
          # strace # System call tracer
        ];

      in
      {
        devShells.default = pkgs.mkShell {
          inherit buildInputs nativeBuildInputs runtimeDependencies;

          LD_LIBRARY_PATH = lib.makeLibraryPath (buildInputs ++ nativeBuildInputs ++ runtimeDependencies);
          # RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
          # # Compiler flags
          # RUSTFLAGS = "-C link-arg=-Wl,-rpath,${lib.makeLibraryPath runtimeDependencies}";
          # # C/C++ toolchain (useful for native dependencies)
          # CC = "${pkgs.gcc}/bin/gcc";
          # CXX = "${pkgs.gcc}/bin/g++";

          packages = with pkgs; [
            # Additional tools beyond buildInputs
            git
            # curl
            # jq
            # tree
            # htop
          ];

          shellHook = ''
            echo "🦀 Welcome to Rust development environment!"
            echo "Rust version: $(rustc --version)"
            echo "Cargo version: $(cargo --version)"

            # Export additional variables
            export RUST_LOG=debug
            export CARGO_INCREMENTAL=1
          '';

        };
      }
    );
}
