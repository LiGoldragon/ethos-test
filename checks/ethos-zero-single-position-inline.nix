# The refusal name SinglePosition is the design's own (ethos-solution item 2).
# The rule holds after inline expansion: the variant payload Started.{ String }
# is refused as SinglePosition.
# Target: ruled.
{
  pkgs,
  flake,
  system,
  ...
}:
flake.lib.ethosScenario { inherit pkgs flake system; } {
  name = "ethos-zero-single-position-inline";
  statement = "A one-position type is called a new type (d4ae97 vision/ethos.md, 2026-10-06; ethos-solution item 2)";
  target = "ruled";
  script = ''
    generate event
    expect_prefix "Started.{ String }" "$reply" "Rejected.{ @/event.ethos "
    expect_contains "the refusal" "$reply" "SinglePosition"
  '';
}
