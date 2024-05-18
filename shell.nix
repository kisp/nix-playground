{
  pkgs ? import <nixpkgs> { },
}:

pkgs.mkShell {
  buildInputs = with pkgs; [
    ripgrep
    tree
    nixfmt-rfc-style
    emacs-nox
    emacsPackages.magit
    emacsPackages.whitespace-cleanup-mode
    emacsPackages.nix-mode
    emacsPackages.modus-themes
    emacsPackages.smartparens
    emacsPackages.paredit
    emacsPackages.multiple-cursors
  ];
}
