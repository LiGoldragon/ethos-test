# The generator's reading of "a concrete type in an input is a trait not yet
# named": String in a capability's input is refused as TraitWanted.
# Target: pass.
{
  pkgs,
  flake,
  system,
  ...
}:
flake.lib.ethosScenario { inherit pkgs flake system; } {
  name = "ethos-zero-trait-concrete-input";
  statement = "Trait (the generator's reading)";
  target = "pass";
  script = ''
    generate concrete
    expect "a concrete type in an input" "$reply" "Rejected.{ @/concrete.ethos { 4 28 } Conceptual.{ [ 1 2 0 1 0 1 0 0 ] TraitWanted.String } }"
  '';
}
