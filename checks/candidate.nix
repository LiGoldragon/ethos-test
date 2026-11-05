# The second pinned check: every scenario's drive against the held set's
# candidate tree (flake input ethos-zero-candidate, with harness-candidate/
# on the set's datom-codec), under each scenario's candidateTarget. The
# check against 07714b (each ethos-zero-* check and the report) is
# unchanged. Building it builds every candidate scenario; a broken or
# unexpectedly passing one fails it. When the set lands, the two are one.
# Read it with `nix build .#checks.<system>.candidate && cat result`.
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
  name = "candidate";
  vision = flake.lib.vision;
  subject = "The held set's candidate tree: ethos-zero at ${inputs.ethos-zero-candidate.rev} (07714b plus item12-on-item5 and item6-on-set).";
  scenarioOutcome = check: check.candidate;
}
