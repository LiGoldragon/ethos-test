# "A capability speaks in Self, the trait's own parameters and other traits; a
# concrete type in an input is a trait not yet named": String in an input is
# refused as TraitWanted; a trait in an input becomes a parameter bounded by
# it, as ethos has no generics, only traits.
# Target: pass.
{
  pkgs,
  flake,
  system,
  ...
}:
flake.lib.ethosScenario { inherit pkgs flake system; } {
  name = "ethos-zero-trait";
  statement = "Trait";
  target = "pass";
  script = ''
    generate concrete
    expect "a concrete type in an input" "$reply" "Rejected.{ @/concrete.ethos { 4 28 } Conceptual.{ [ 1 2 0 1 0 1 0 0 ] TraitWanted.String } }"
    generate bounded
    expect "a trait in an input" "$reply" "Generated.[ @work/gen/bounded/bounded.rs ]"
    expect_item "the bounded parameter" "fn resolve<N: protos::Textualizable>(&self, input: N) -> Self where Self: Sized;"
  '';
}
