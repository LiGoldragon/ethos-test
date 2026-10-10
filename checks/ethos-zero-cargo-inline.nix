# A type declared where it is used is a full type whose derived name
# carries an underscore: the variant PathOverlap.{ Lock Lock } carries
# PathOverlap_Data, named for the variant, and DuplicateName.Lock carries the
# named Lock. rustc accepts the result.
# Target: pass.
{
  pkgs,
  flake,
  system,
  ...
}:
flake.lib.ethosScenario { inherit pkgs flake system; } {
  name = "ethos-zero-cargo-inline";
  statement = "Inline types";
  target = "pass";
  script = ''
    generate inline
    expect "inline" "$reply" "Generated.[ @work/gen/inline/inline.rs ]"
    expect_item "the derived payload" "pub struct PathOverlap_Data { pub first_lock: Lock, pub second_lock: Lock, }"
    expect_item "the enum" "pub enum LockRejection { DuplicateName(Lock), PathOverlap(PathOverlap_Data), }"
    compiles "with datom" datom "$rust" 'fn main() { let _ = |lock: Lock| LockRejection::PathOverlap(PathOverlap_Data { first_lock: lock.clone(), second_lock: lock }); }'
  '';
}
