{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=24.11";
    flake-utils.url = "github:numtide/flake-utils";
    zig_overlay.url = "github:mitchellh/zig-overlay";
  };

  outputs = { self, flake-utils, zig_overlay, nixpkgs, ... }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs { inherit system; };
      zig = zig_overlay.packages.${system}."0.14.0";
    in {
    devShell = pkgs.mkShell {
        packages = [
          zig
        ];
    };

    packages.x86_64-linux.hello = nixpkgs.legacyPackages.x86_64-linux.hello;

    packages.x86_64-linux.default = self.packages.x86_64-linux.hello;

  });
}
