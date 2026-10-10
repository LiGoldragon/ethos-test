# The complex trait over a constraint rustc can resolve: the source bounds
# is the harness crate itself (extern crate self as bounds), where Clonable
# is Clone under a trait name. rustc accepts the trait and an interaction.
# Target: pass.
{
  pkgs,
  flake,
  system,
  ...
}:
flake.lib.ethosScenario { inherit pkgs flake system; } {
  name = "ethos-zero-cargo-trait-complex";
  statement = "Trait syntax";
  target = "pass";
  script = ''
    generate streamable
    expect "streamable" "$reply" "Generated.[ @work/gen/streamable/streamable.rs ]"
    expect_item "the complex trait" "pub trait Streamable: Fillable { type Item: bounds::Clonable; const CAPACITY: i64; fn next(&mut self) -> std::option::Option<Self::Item>; }"
    main=$(cat <<'RS'
    extern crate self as bounds;
    pub trait Clonable: Clone {}
    impl<T: Clone> Clonable for T {}
    struct Counter(i64);
    impl Fillable for Counter { fn create() -> Self { Counter(0) } }
    impl Streamable for Counter {
        type Item = i64;
        const CAPACITY: i64 = 3;
        fn next(&mut self) -> Option<i64> { self.0 += 1; (self.0 <= Self::CAPACITY).then_some(self.0) }
    }
    fn main() { let mut counter = Counter::create(); while counter.next().is_some() {} }
    RS
    )
    compiles "an interaction" datom "$rust" "$main"
  '';
}
