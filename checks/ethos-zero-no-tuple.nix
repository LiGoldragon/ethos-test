# "No tuple in the code we design": a variant of two positions carries a
# named struct, never a tuple variant.
# Target: pass.
{
  pkgs,
  flake,
  system,
  ...
}:
flake.lib.ethosScenario { inherit pkgs flake system; } {
  name = "ethos-zero-no-tuple";
  statement = "Associations";
  target = "pass";
  script = ''
    generate inline
    expect "inline" "$reply" "Generated.[ @work/gen/inline/inline.rs ]"
    expect_no_item "a tuple variant" "PathOverlap(Lock, Lock)"
    expect_item "a named payload" "PathOverlap(PathOverlap_Data)"
  '';
}
