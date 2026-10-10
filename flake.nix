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

    # The held set's candidate tree: ethos-zero 07714b plus
    # item12-on-item5-ethos-zero.patch and item6-on-set-ethos-zero.patch, its
    # datom-codec and protos pins moved to the set's patched commits, which sit
    # on candidate/held-set-datom-codec and candidate/held-set-protos of the
    # same repository. Read only by checks/candidate.nix. When the set lands
    # on main, this input and that check fold into ethos-zero and the report.
    ethos-zero-candidate = {
      url = "github:LiGoldragon/ethos-zero/candidate/held-set-bare";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.rust-build.follows = "rust-build";
    };
  };

  outputs = inputs: inputs.blueprint { inherit inputs; };
}
