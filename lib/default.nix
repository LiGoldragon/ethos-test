{ inputs, ... }:
{
  # One entry per component a scenario drives. A scenario reaches these as
  # `flake.lib.components.<name>` and adds only its own drive and assertions.
  # The candidate pair is the held set's tree and a harness crate on the set's
  # datom-codec; checks/candidate.nix runs every scenario against it.
  components = {
    ethos-zero = import ./components/ethos-zero.nix { source = inputs.ethos-zero; };
    ethos-zero-candidate = import ./components/ethos-zero.nix {
      source = inputs.ethos-zero-candidate;
    };
    cargo = import ./components/cargo.nix {
      inherit inputs;
      harness = ../harness;
    };
    cargo-candidate = import ./components/cargo.nix {
      inherit inputs;
      harness = ../harness-candidate;
    };
  };

  # The psyche-skills revision of vision/ethos.md the checks are written to.
  vision = "850fd27228cb7c4a5fb71f7409109d4a437578be";

  # The frame every scenario shares:
  # `flake.lib.ethosScenario { pkgs, flake, system }
  #   { name, statement, target, candidateTarget ? target, script }`.
  ethosScenario = import ./ethos-scenario.nix;
}
