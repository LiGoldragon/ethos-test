{ inputs, ... }:
{
  # One entry per component a scenario drives. A scenario reaches these as
  # `flake.lib.components.<name>` and adds only its own drive and assertions.
  components = {
    ethos-zero = import ./components/ethos-zero.nix { inherit inputs; };
    cargo = import ./components/cargo.nix { inherit inputs; };
  };

  # The psyche-skills revision of vision/ethos.md the checks are written to.
  vision = "850fd27228cb7c4a5fb71f7409109d4a437578be";

  # The frame every scenario shares:
  # `flake.lib.ethosScenario { pkgs, flake, system } { name, statement, target, script }`.
  ethosScenario = import ./ethos-scenario.nix;
}
