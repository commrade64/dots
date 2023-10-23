{
  description = "My new NixOS config";

  inputs = {
    # Nixpkgs
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Hardware configs for different devices
    hardware = {
      url = "github:nixos/nixos-hardware";
    };

    # Locate nix binaries easily
    nix-index-db = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Zsh plugins
    fzf-tab = {
      url = "github:Aloxaf/fzf-tab";
      flake = false;
    };

    # Emacs Overlays
    emacs-overlay = {
      url = "github:nix-community/emacs-overlay";
      #flake = false;
    };

    # Proprietary Apple fonts
    apple-fonts = {
      url = "github:swttrh/apple-fonts";
    };

    sf-mono-liga = {
      url = "github:swttrh/sf-mono-liga";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... } @ inputs:
  let
    vars = {
      username = "commrade64";
      editor = "nvim";
      browser = "firefox";
      terminal = "alacritty";
    };
  in {
    nixosConfigurations = (
      import ./hosts {
        inherit (nixpkgs) lib;
	      inherit inputs nixpkgs home-manager vars;
      }
    );
  };
}
