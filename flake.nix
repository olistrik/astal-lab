{
  description = "dev shell for nix people";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    ags = {
      url = "github:aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { flake-utils, nixpkgs, ags, ... }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = import nixpkgs { inherit system; };
        in
        {
          packages.default = ags.lib.bundle {
            inherit pkgs;
            src = ./core;
            name = "astal-lab-core";
            entry = "app.ts";
          };

          devShells.default = pkgs.mkShell {
            packages = with pkgs;
              [
                git
                bun
                (ags.packages."${system}".default.override {
                  extraPackages = [ ];
                })
              ];
          };
        });
}
