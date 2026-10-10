# "In ethos there are no generics, only traits": a trait in a capability's
# input becomes a method parameter bounded by it; rustc accepts the trait
# and an interaction of it.
# Target: pass.
{
  pkgs,
  flake,
  system,
  ...
}:
flake.lib.ethosScenario { inherit pkgs flake system; } {
  name = "ethos-zero-cargo-trait";
  statement = "Trait";
  target = "pass";
  script = ''
    generate bounded
    expect "a trait in an input" "$reply" "Generated.[ @work/gen/bounded/bounded.rs ]"
    expect_item "the bounded parameter" "fn resolve<N: protos::Textualizable>(&self, input: N) -> Self"
    compiles "an interaction" datom "$rust" 'struct Echo; impl Resolvable for Echo { fn resolve<N: protos::Textualizable>(&self, _input: N) -> Self { Echo } } fn main() {}'
  '';
}
