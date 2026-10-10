# A struct holds two or more positions: Age.{ Integer } is refused as
# SinglePosition, and Age.Integer is accepted.
# Target: ruled.
{
  pkgs,
  flake,
  system,
  ...
}:
flake.lib.ethosScenario { inherit pkgs flake system; } {
  name = "ethos-zero-single-position";
  statement = "Ethos-solution item 2: Single-field structs and double wrapping are refused";
  target = "ruled";
  script = ''
    generate new-type
    expect "Age.Integer" "$reply" "Generated.[ @work/gen/new-type/new-type.rs ]"
    generate single
    expect_prefix "Age.{ Integer }" "$reply" "Rejected.{ @/single.ethos "
    expect_contains "the refusal" "$reply" "SinglePosition"
  '';
}
