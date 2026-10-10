# An association asserts the type bears the trait: the generated Rust
# carries a compile-time assertion, so rustc accepts it with a hand-written
# interaction and refuses it (E0277) without one.
# Target: pass.
{
  pkgs,
  flake,
  system,
  ...
}:
flake.lib.ethosScenario { inherit pkgs flake system; } {
  name = "ethos-zero-cargo-trait-explicit";
  statement = "Traits are explicit; bodies are hand-written";
  target = "pass";
  script = ''
    generate record
    expect "record" "$reply" "Generated.[ @work/gen/record/record.rs ]"
    expect_item "the trait" "pub trait Summarizable { fn summarize(&self) -> String; }"
    expect_item "the assertion" "const _: () = { fn assert_record_summarizable<T: Summarizable>() {} let _ = assert_record_summarizable::<Record>; };"
    compiles "with the hand-written body" datom "$rust" 'impl Summarizable for Record { fn summarize(&self) -> String { self.string.clone() } } fn main() {}'
    refused_by_rustc "without it" datom "$rust" 'fn main() {}' E0277
  '';
}
