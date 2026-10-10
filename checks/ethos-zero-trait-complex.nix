# A complex trait: supertraits, associated types with their constraints,
# associated constants (upper case, name dot type) and capabilities, each in
# its bracket; the vision's Streamable, as given.
# Target: pass.
{
  pkgs,
  flake,
  system,
  ...
}:
flake.lib.ethosScenario { inherit pkgs flake system; } {
  name = "ethos-zero-trait-complex";
  statement = "Trait syntax";
  target = "pass";
  script = ''
    generate streamable
    expect "streamable" "$reply" "Generated.[ @work/gen/streamable/streamable.rs ]"
    expect_item "the complex trait" "pub trait Streamable: Fillable { type Item: std::Serializable; const CAPACITY: i64; fn next(&mut self) -> std::option::Option<Self::Item>; }"
  '';
}
