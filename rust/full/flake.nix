{
  description = "Rust Dev Environment (Hybrid: Nix Env + User VSCode Config)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, flake-utils, rust-overlay, ... }:
    flake-utils.lib.eachSystem [ "x86_64-linux" "aarch64-linux" ] (system:
      let
        overlays = [ (import rust-overlay) ];
        pkgs = import nixpkgs {
          inherit system overlays;
          config.allowUnfree = true;
        };
        inherit (pkgs) lib;

        # 1. The Toolchain
        rustToolchain = pkgs.rust-bin.stable.latest.default.override {
          extensions = [ "rust-src" "rust-analyzer" "clippy" "rustfmt" ];
        };

        # 2. Libraries
        libraries = with pkgs; [
          openssl sqlite udev alsa-lib
          wayland vulkan-loader vulkan-headers fontconfig freetype libinput libxkbcommon
          xorg.libxcb xorg.libX11 xorg.libXcursor xorg.libXrandr xorg.libXi xorg.libXext
        ];

        # 3. Build Tools
        nativeBuildInputs = with pkgs; [ pkg-config cmake clang mold ];

      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = [ rustToolchain pkgs.vscode ] ++ libraries; # Just standard vscode
          inherit nativeBuildInputs;

          # 4. Environment Variables (The Magic Sauce)
          RUST_SRC_PATH = "${rustToolchain}/lib/rustlib/src/rust/library";
          LD_LIBRARY_PATH = lib.makeLibraryPath libraries;
          PKG_CONFIG_PATH = "${lib.makeSearchPathOutput "dev" "lib/pkgconfig" libraries}";
          RUSTFLAGS = "-C link-arg=-fuse-ld=mold";

          # 5. Shell Hook: Launch VS Code with the right env, but USER config
          shellHook = ''
            echo "✅ Nix DevShell Active (Hybrid Mode)"
            echo "   - Rust: $(rustc --version)"
            echo ""
            echo "ℹ️  To run VS Code with your USER extensions + THIS environment:"
            echo "   $ code ."
            echo ""
            echo "   (This uses your normal ~/.vscode/extensions but injects the Rust paths)"
          '';
        };
      }
    );
}
