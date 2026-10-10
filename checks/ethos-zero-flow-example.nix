# A fixture, not a statement: the Flow Nexus's four ethos files (ethos-zero
# 07714b fixtures/print/flow-*.ethos) generate.
# Target: pass.
{
  pkgs,
  flake,
  system,
  ...
}:
flake.lib.ethosScenario { inherit pkgs flake system; } {
  name = "ethos-zero-flow-example";
  statement = "Flow, a current best example";
  target = "pass";
  script = ''
    for root in library signal operation memory; do
      generate "flow-$root"
      expect "flow-$root" "$reply" "Generated.[ @work/gen/flow-$root/flow-$root.rs ]"
    done
  '';
}
