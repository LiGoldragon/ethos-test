# The report: every scenario's outcome, one line each, grouped as passing
# and expected-failing (a ruled target, with the expectation it missed),
# then the steps each ran. Building it builds every scenario; a broken or
# unexpectedly passing scenario fails its own check and therefore this one.
# Read it with `nix build .#checks.<system>.report && cat result`.
{
  pkgs,
  flake,
  inputs,
  system,
  ...
}:
(import ../lib/scenario-report.nix) {
  inherit pkgs;
  checks = flake.checks.${system};
  name = "report";
  vision = flake.lib.vision;
  subject = "ethos-zero pinned at ${inputs.ethos-zero.rev}.";
  scenarioOutcome = check: check;
}
