# A concrete type in a capability's input is written as that type: the
# living ruled «we can allow types and traits signatures for now», landed in
# ethos-zero 20.0.0. String in an input gives `input: String`; rustc accepts
# the trait and an interaction of it.
# Target: ruled until ethos-test repins ethos-zero at 20.0.0 or later; the
# pinned 07714b still refuses it as TraitWanted.String.
{
  pkgs,
  flake,
  system,
  ...
}:
flake.lib.ethosScenario { inherit pkgs flake system; } {
  name = "ethos-zero-trait-concrete-input";
  statement = "Trait (the living's ruling: types and trait signatures stand in an input)";
  target = "ruled";
  script = ''
    generate concrete
    expect "a concrete type in an input" "$reply" "Generated.[ @work/gen/concrete/concrete.rs ]"
    expect_item "the input written as its type" "fn resolve(&self, input: String) -> Self where Self: Sized;"
    compiles "an interaction" datom "$rust" 'struct Echo; impl Resolvable for Echo { fn resolve(&self, _input: String) -> Self { Echo } } fn main() {}'
  '';
}
