# Flow's library declares FlowId.String, a string for now (the comment says
# so); it generates a new type, and rustc accepts it.
# Target: ruled.
{
  pkgs,
  flake,
  system,
  ...
}:
flake.lib.ethosScenario { inherit pkgs flake system; } {
  name = "ethos-zero-cargo-flow-id";
  statement = "Ethos-solution item 6: Flow as the current best example";
  target = "ruled";
  script = ''
    generate flow-library
    expect "flow-library" "$reply" "Generated.[ @work/gen/flow-library/flow-library.rs ]"
    expect_item "FlowId" "pub struct FlowId(pub String);"
    compiles "with datom" datom "$rust" 'fn main() { let _ = FlowId("7".to_owned()); }'
  '';
}
