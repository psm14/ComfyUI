{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
        comfyui-python = pkgs.python310.withPackages (ps: with ps; [
          numpy
          sentencepiece
        ]);
      in
      {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            comfyui-python
          ] ++ lib.optionals stdenv.isDarwin [
          ];
        };
      }
    );
}
