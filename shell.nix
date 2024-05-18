{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    pkgs.ripgrep
    pkgs.emacs-nox
    pkgs.emacsPackages.magit
    pkgs.emacsPackages.whitespace-cleanup-mode
    pkgs.emacsPackages.nix-mode
    pkgs.emacsPackages.modus-themes
  ];
}
