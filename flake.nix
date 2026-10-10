{
  description = "ethos-test: acceptance checks that run the real ethos-zero on ethos fixtures, written to the Ethos vision (psyche-skills vision/ethos.md at 850fd27) and the ruled items of d5df1d's ethos solution.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    blueprint = {
      url = "github:numtide/blueprint";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    rust-build = {
      url = "github:LiGoldragon/rust-build";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ethos-zero = {
      url = "github:LiGoldragon/ethos-zero";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.rust-build.follows = "rust-build";
    };
  };

  outputs = inputs: inputs.blueprint { inherit inputs; };
}
