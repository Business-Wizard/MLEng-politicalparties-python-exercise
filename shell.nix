let
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-24.05";
  pkgs = import nixpkgs { config = {}; overlays = []; };
in

let
  shell_packages = with pkgs; [
    docker
      podman
  ];
in

pkgs.mkShellNoCC {
  packages = shell_packages;
}
