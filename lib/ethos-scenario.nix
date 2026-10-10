# The frame every scenario shares. A scenario names the statement it tests
# (the heading it quotes), its target, and a drive in bash over the helpers
# of ethos-scenario.sh: it runs ethos-zero on its fixtures
# (fixtures/<name>/), and asserts the reply, the generated Rust, or what
# rustc and the built program do with that Rust.
#
# target = "pass": the drive must meet every expectation.
# target = "ruled": a ruled behaviour not yet landed in the pinned
# ethos-zero, expected to miss. A miss is recorded as expected-failing and
# the check builds; a drive that meets every expectation fails the check, so
# the scenario is promoted to "pass" when the behaviour lands.
# A failure of the rig (the frame, the shell, the harness build itself)
# fails the check either way.
#
# The same drive runs a second time against the held set's candidate tree,
# as the derivation's `candidate` attribute, under candidateTarget: a ruled
# target the set satisfies is "pass" there. checks/candidate.nix gathers them.
{
  pkgs,
  flake,
  system,
}:
{
  name,
  statement,
  target,
  candidateTarget ? target,
  script,
}:
let
  fixtures = ../fixtures + "/${name}";
  run =
    {
      pname,
      target,
      ethosZero,
      cargo,
      passthru ? { },
    }:
    assert builtins.elem target [
      "pass"
      "ruled"
    ];
    cargo.derivation {
      inherit pname passthru;
      nativeBuildInputs = [ ethosZero.package ];
      buildPhaseCargoCommand = ''
        NAME=${pkgs.lib.escapeShellArg name}
        STATEMENT=${pkgs.lib.escapeShellArg statement}
        TARGET=${target}
        FIXTURES=${if builtins.pathExists fixtures then fixtures else "/nonexistent"}
        ${builtins.readFile ./ethos-scenario.sh}

        drive() {
        ${script}
        }

        scenario
      '';
      installPhaseCommand = "";
    };
in
run {
  pname = name;
  inherit target;
  ethosZero = flake.lib.components.ethos-zero { inherit system; };
  cargo = flake.lib.components.cargo { inherit pkgs system; };
  passthru.candidate = run {
    pname = "${name}-candidate";
    target = candidateTarget;
    ethosZero = flake.lib.components.ethos-zero-candidate { inherit system; };
    cargo = flake.lib.components.cargo-candidate { inherit pkgs system; };
  };
}
