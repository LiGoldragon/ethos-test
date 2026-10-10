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
  statement = "Ethos-solution item 2: Single-field structs and double wrapping are refused";
  target = "ruled";
  script = ''
    generate event
    expect_prefix "Started.{ String }" "$reply" "Rejected.{ @/event.ethos "
    expect_contains "the refusal" "$reply" "SinglePosition"
  '';
}
