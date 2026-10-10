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
let
  scenarios = pkgs.lib.filterAttrs (
    name: _: pkgs.lib.hasPrefix "ethos-zero-" name
  ) flake.checks.${system};
  outcomes = pkgs.lib.concatMapStringsSep " " (check: "${check.candidate}/outcome") (
    builtins.attrValues scenarios
  );
in
pkgs.runCommand "candidate" { } ''
  {
    echo "Written to psyche-skills vision/ethos.md at ${flake.lib.vision}, and the ruled items of flows/d5df1d/reports/ethos-solution.md."
    echo "The held set's candidate tree: ethos-zero at ${inputs.ethos-zero-candidate.rev} (07714b plus item12-on-item5 and item6-on-set)."
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
