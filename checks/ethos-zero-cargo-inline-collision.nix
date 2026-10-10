# "Its derived name carries an underscore ... so it never collides": two
# enums that each declare a variant X inline get distinct derived payloads,
# P_X_Data and Q_X_Data, and rustc accepts both; an authored name equal to a
# derived one is refused as a Duplicate.
# Target: pass.
{
  pkgs,
  flake,
  system,
  ...
}:
flake.lib.ethosScenario { inherit pkgs flake system; } {
  name = "ethos-zero-cargo-inline-collision";
  statement = "Inline types";
  target = "pass";
  script = ''
    generate collide
    expect "collide" "$reply" "Generated.[ @work/gen/collide/collide.rs ]"
    expect_item "the first payload" "pub struct P_X_Data { pub string: String, pub integer: i64, }"
    expect_item "the second payload" "pub struct Q_X_Data { pub integer: i64, pub string: String, }"
    compiles "both" datom "$rust" 'fn main() { let _ = (P::X(P_X_Data { string: String::new(), integer: 1 }), Q::X(Q_X_Data { integer: 1, string: String::new() })); }'
    generate authored
    expect "an authored name equal to a derived one" "$reply" "Rejected.{ @/authored.ethos { 4 3 } Conceptual.{ [ 1 1 1 0 ] Duplicate.PathOverlap_Data } }"
  '';
}
