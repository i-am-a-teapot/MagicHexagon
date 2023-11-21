{
  description = "Magic Hexagon project";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/23.05";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = inputs@{ self, nixpkgs, ... }: inputs.utils.lib.eachSystem [
    "x86_64-linux" "i686-linux" "aarch64-linux" "x86_64-darwin"
  ] (system: let pkgs = import nixpkgs {
                   inherit system;
                 };
             in {
               devShell = pkgs.mkShell rec {
                 name = "effp23";

                 packages = with pkgs; [
                   # Development Tools
                   llvmPackages_16.clang
                   linuxPackages_latest.perf
                   cmake
                   cmakeCurses
                 ];
               };
             });
}
