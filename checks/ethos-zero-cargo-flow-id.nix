# Flow's library declares FlowId.String, a string for now (the comment says
# so); it generates a new type, not an alias, and rustc accepts it.
# Target: ruled.
{
  pkgs,
  flake,
  system,
  ...
}:
flake.lib.ethosScenario { inherit pkgs flake system; } {
  name = "ethos-zero-cargo-flow-id";
  statement = "Newtypes, not type aliases (d4ae97 vision/ethos.md, 2026-10-06; ethos-solution item 6)";
  target = "ruled";
  script = ''
    generate flow-library
    expect "flow-library" "$reply" "Generated.[ @work/gen/flow-library/flow-library.rs ]"
    expect_no_item "FlowId, no alias" "pub type FlowId"
    expect_item "FlowId, a struct" "pub struct FlowId"
    compiles "with datom" datom "$rust" 'fn main() {}'
  '';
}
