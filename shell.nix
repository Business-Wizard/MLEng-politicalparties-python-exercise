let
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-24.05";
  pkgs = import nixpkgs { config = {}; overlays = []; };
in

let
  shell_packages = with pkgs; [
    rye
    docker
      podman
  ];
in

pkgs.mkShellNoCC {
  packages = shell_packages;

  shellHook = ''
    if [ ! -d ".venv" ]; then
      echo -e "Creating a virtual environment..."
      rye sync
    fi

    echo -e "Activating the virtual environment..."
    source .venv/bin/activate || source .venv/bin/activate

    # if os is linux, no podman vm is needed
    if [ "$(uname)" != "Linux" ]; then
      echo -e "Starting podman machine..."
      podman machine start
    fi

    echo -e "\nNix-shell is ready!"
  '';
}
