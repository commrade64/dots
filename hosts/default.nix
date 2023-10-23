{ lib, inputs, nixpkgs, home-manager, vars, ... }: let
  lib = nixpkgs.lib;

  system = "x86_64-linux";

  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
    overlays = [ (import inputs.emacs-overlay) ];
  };
in {
  desktop = lib.nixosSystem {
    inherit system;
    specialArgs = {
      inherit inputs pkgs home-manager vars;
      host = {
        hostname = "desktop";
	main-monitor = "DP-2";
      };
    };
    modules = [
      ./desktop
      ./config.nix

      home-manager.nixosModules.home-manager {
        home-manager = {
	  useGlobalPkgs = true;
	  useUserPackages = true;

	  users.${vars.username} = {
            programs.home-manager.enable = true;
            systemd.user.startServices = "sd-switch";
            home.stateVersion = "23.11";
	  };
	};
      }
    ];
  };
}
