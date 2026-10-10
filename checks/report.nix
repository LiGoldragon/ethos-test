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
let
  scenarios = pkgs.lib.filterAttrs (
    name: _: pkgs.lib.hasPrefix "ethos-zero-" name
  ) flake.checks.${system};
  outcomes = pkgs.lib.concatMapStringsSep " " (check: "${check}/outcome") (
    builtins.attrValues scenarios
  );
in
pkgs.runCommand "report" { } ''
  {
    echo "Written to psyche-skills vision/ethos.md at ${flake.lib.vision}, and the ruled items of flows/d5df1d/reports/ethos-solution.md."
    echo "ethos-zero pinned at ${inputs.ethos-zero.rev}."
    echo
    echo "passing:"
    grep -h ': passing$' ${outcomes} | sed 's/^/  /' || true
    echo
    echo "expected-failing (ruled targets):"
    grep -h ': expected-failing (ruled target): ' ${outcomes} | sed 's/^/  /' || true
    echo
    echo "steps:"
    cat ${outcomes}
  } > $out
  cat $out
''
