# Two new types over String are distinct types: rustc refuses a LockName
# where a FlowId is wanted (E0308).
# Target: ruled; against the held set's candidate tree, pass.
{
  pkgs,
  flake,
  system,
  ...
}:
flake.lib.ethosScenario { inherit pkgs flake system; } {
  name = "ethos-zero-cargo-newtype-distinct";
  statement = "Newtypes, not type aliases (d4ae97 vision/ethos.md, 2026-10-06; ethos-solution item 1)";
  target = "ruled";
  candidateTarget = "pass";
  script = ''
    generate distinct
    expect "distinct" "$reply" "Generated.[ @work/gen/distinct/distinct.rs ]"
    refused_by_rustc "a LockName given for a FlowId" datom "$rust" 'fn take(_: FlowId) {} fn give() -> LockName { unimplemented!() } fn main() { take(give()); }' E0308
  '';
}
