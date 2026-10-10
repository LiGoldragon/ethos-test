# "A vector, a struct, or an enum, each a full type with a derived name,
# recursively": an inline enum carries a variant with an inline struct; each
# is a full type with a derived name, and rustc accepts them.
# Target: pass.
{
  pkgs,
  flake,
  system,
  ...
}:
flake.lib.ethosScenario { inherit pkgs flake system; } {
  name = "ethos-zero-cargo-inline-recursive";
  statement = "A variant may declare its payload inline";
  target = "pass";
  script = ''
    generate recursive
    expect "recursive" "$reply" "Generated.[ @work/gen/recursive/recursive.rs ]"
    expect_item "the inner struct" "pub struct Io_Data_Refused_Data { pub string: String, pub integer: i64, }"
    expect_item "the inline enum" "pub enum Io_Data { Closed, Refused(Io_Data_Refused_Data), }"
    expect_item "the outer enum" "pub enum Failure { Io(Io_Data), Other, }"
    compiles "with datom" datom "$rust" 'fn main() { let _ = Failure::Io(Io_Data::Refused(Io_Data_Refused_Data { string: String::new(), integer: 1 })); }'
  '';
}
