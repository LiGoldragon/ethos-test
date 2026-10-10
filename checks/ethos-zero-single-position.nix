# The refusal name SinglePosition is the design's own (ethos-solution item 2).
# A struct holds two or more positions: Age.{ Integer } is refused as
# SinglePosition, and Age.Integer is accepted.
# Target: ruled; against the held set's candidate tree, pass.
{
  pkgs,
  flake,
  system,
  ...
}:
flake.lib.ethosScenario { inherit pkgs flake system; } {
  name = "ethos-zero-single-position";
  statement = "A one-position type is called a new type (d4ae97 vision/ethos.md, 2026-10-06; ethos-solution item 2)";
  target = "ruled";
  candidateTarget = "pass";
  script = ''
    generate new-type
    expect "Age.Integer" "$reply" "Generated.[ @work/gen/new-type/new-type.rs ]"
    generate single
    expect_prefix "Age.{ Integer }" "$reply" "Rejected.{ @/single.ethos "
    expect_contains "the refusal" "$reply" "SinglePosition"
  '';
}
