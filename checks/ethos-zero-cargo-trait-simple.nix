# A simple trait: the receiver after a capability's head names who is
# called, . self, ! mutable self, : no self; a capability with inputs is a
# headed brace, inputs then yield. rustc accepts an interaction of it.
# Target: pass.
{
  pkgs,
  flake,
  system,
  ...
}:
flake.lib.ethosScenario { inherit pkgs flake system; } {
  name = "ethos-zero-cargo-trait-simple";
  statement = "Trait syntax";
  target = "pass";
  script = ''
    generate fillable
    expect "fillable" "$reply" "Generated.[ @work/gen/fillable/fillable.rs ]"
    expect_item "! takes mutable self, with an input" "fn push(&mut self, input: Self) -> std::result::Result<i64, SinkError>"
    expect_item "! takes mutable self" "fn drain(&mut self) -> std::vec::Vec<String>;"
    expect_item ". takes self" "fn peek(&self) -> i64;"
    expect_item ": takes no self" "fn create() -> Self"
    main=$(cat <<'RS'
    struct Sink(Vec<String>);
    impl Fillable for Sink {
        fn push(&mut self, input: Self) -> Result<i64, SinkError> { self.0.extend(input.0); Ok(self.0.len() as i64) }
        fn drain(&mut self) -> Vec<String> { std::mem::take(&mut self.0) }
        fn peek(&self) -> i64 { self.0.len() as i64 }
        fn create() -> Self { Sink(Vec::new()) }
    }
    fn main() { let mut sink = Sink::create(); let _ = sink.push(Sink::create()); let _ = sink.drain(); let _ = SinkError::Full; }
    RS
    )
    compiles "an interaction" datom "$rust" "$main"
  '';
}
