# In a Signal, a head then a symbol in the first two sections is a variant
# of Query or Response; where types are defined a bracket is an enum, never
# a vector. rustc accepts the result.
# Target: pass.
{
  pkgs,
  flake,
  system,
  ...
}:
flake.lib.ethosScenario { inherit pkgs flake system; } {
  name = "ethos-zero-cargo-signal";
  statement = "Shapes and placement";
  target = "pass";
  script = ''
    generate signal
    expect "signal" "$reply" "Generated.[ @work/gen/signal/signal.rs ]"
    expect_item "queries" "pub enum Query { Lock(LockRequest), Release(i64), }"
    expect_item "responses" "pub enum Response { Locked(Lock), Released(Lock), }"
    expect_item "a bracket among types is an enum" "pub enum Rank { Primary, Secondary, }"
    compiles "with datom" datom "$rust" 'fn main() { let _ = Query::Lock(LockRequest { string: String::new(), rank: Rank::Primary }); }'
  '';
}
