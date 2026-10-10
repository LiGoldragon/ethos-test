# The same head over constraints rustc can resolve: the source bounds is
# the harness crate itself (extern crate self as bounds), whose traits are
# Clone, Send and Debug under trait names. rustc accepts the trait and an
# interaction of it.
# Target: pass.
{
  pkgs,
  flake,
  system,
  ...
}:
flake.lib.ethosScenario { inherit pkgs flake system; } {
  name = "ethos-zero-cargo-identity";
  statement = "Identity";
  target = "pass";
  script = ''
    generate processable
    expect "processable" "$reply" "Generated.[ @work/gen/processable/processable.rs ]"
    expect_item "the head" "pub trait Processable<A: bounds::Clonable + bounds::Sendable, B: bounds::Debuggable> {"
    compiles "an interaction" datom "$rust" 'extern crate self as bounds; pub trait Clonable: Clone {} impl<T: Clone> Clonable for T {} pub trait Sendable: Send {} impl<T: Send> Sendable for T {} pub trait Debuggable: std::fmt::Debug {} impl<T: std::fmt::Debug> Debuggable for T {} struct Job; impl Processable<String, i64> for Job { fn create() -> Self { Job } } fn main() { let _ = <Job as Processable<String, i64>>::create(); }'
  '';
}
