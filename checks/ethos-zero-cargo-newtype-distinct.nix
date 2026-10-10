# Two new types over String are distinct types: rustc refuses a LockName
# where a FlowId is wanted (E0308).
# Target: ruled.
{
  pkgs,
  flake,
  system,
  ...
}:
flake.lib.ethosScenario { inherit pkgs flake system; } {
  name = "ethos-zero-cargo-newtype-distinct";
  statement = "Ethos-solution item 1: A declaration Name.Type is a new type, not an alias";
  target = "ruled";
  script = ''
    generate distinct
    expect "distinct" "$reply" "Generated.[ @work/gen/distinct/distinct.rs ]"
    refused_by_rustc "a LockName given for a FlowId" datom "$rust" 'fn take(_: FlowId) {} fn give() -> LockName { unimplemented!() } fn main() { take(give()); }' E0308
  '';
}
