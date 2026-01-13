# cosmic-ext-applet-next-meeting
Applet for Cosmic DE that shows your next meeting with button to join.

## Build
```
nix-build -E 'with import <nixpkgs> {}; callPackage ./package.nix {}'
```

## Install
```
nix-env -i -f ./package.nix
```

## Import
Non-flake:
```
let
  nixpkgs = import <nixpkgs> {};
  src = builtins.fetchTarball "https://github.com/dangrover/next-meeting-for-cosmic/archive/refs/heads/main.tar.gz";
  pkg = nixpkgs.callPackage (src + "/package.nix") {};
in
  pkg
```

Flake:
```
{
  inputs.cosmic-next-meeting = {
    url = "github:dangrover/next-meeting-for-cosmic";
    flake = false;
  };

  outputs = { self, nixpkgs, cosmic-next-meeting, ... }:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
    in {
      packages.x86_64-linux.default =
        pkgs.callPackage "${cosmic-next-meeting}/package.nix" {};
    };
}
```
