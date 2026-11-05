# Render the outcomes of every ethos-zero scenario. The caller selects the
# scenario derivation to read, so the same report serves the pinned tree and
# the held candidate tree.
{
  pkgs,
  checks,
  name,
  vision,
  subject,
  scenarioOutcome,
}:
let
  scenarios = pkgs.lib.filterAttrs (
    scenarioName: _: pkgs.lib.hasPrefix "ethos-zero-" scenarioName
  ) checks;
  outcomes = pkgs.lib.concatMapStringsSep " " (check: "${scenarioOutcome check}/outcome") (
    builtins.attrValues scenarios
  );
in
pkgs.runCommand name { } ''
  {
    echo "Written to psyche-skills vision/ethos.md at ${vision}, and the ruled items of flows/d5df1d/reports/ethos-solution.md."
    echo ${pkgs.lib.escapeShellArg subject}
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
