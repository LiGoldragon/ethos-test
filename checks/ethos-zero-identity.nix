# A trait's head is its name and its constraints: a constraint is a trait or
# a bracket of traits, and the head becomes a Rust trait with one generic
# parameter per constraint, bounded by it. The vision's Processable, as given.
# Target: pass.
{
  pkgs,
  flake,
  system,
  ...
}:
flake.lib.ethosScenario { inherit pkgs flake system; } {
  name = "ethos-zero-identity";
  statement = "Identity";
  target = "pass";
  script = ''
    generate processable
    expect "processable" "$reply" "Generated.[ @work/gen/processable/processable.rs ]"
    expect_item "the head" "pub trait Processable<A: std::Clonable + std::Sendable, B: std::Serializable> {"
  '';
}
