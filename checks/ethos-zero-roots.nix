# Four roots: Library, Signal, Operation, Memory. Each is read; Signal
# generates Query and Response from its queries and responses, Operation
# generates one Operation type for every effect, Memory its record types;
# any other head is refused.
# Target: pass.
{
  pkgs,
  flake,
  system,
  ...
}:
flake.lib.ethosScenario { inherit pkgs flake system; } {
  name = "ethos-zero-roots";
  statement = "Roots";
  target = "pass";
  script = ''
    generate library
    expect "Library" "$reply" "Generated.[ @work/gen/library/library.rs ]"
    expect_item "Library types" "pub struct Record { pub string: String, pub integer: i64, }"
    generate signal
    expect "Signal" "$reply" "Generated.[ @work/gen/signal/signal.rs ]"
    expect_item "Signal queries" "pub enum Query { Lock(LockRequest), }"
    expect_item "Signal responses" "pub enum Response { Locked(i64), }"
    generate operation
    expect "Operation" "$reply" "Generated.[ @work/gen/operation/operation.rs ]"
    expect_item "Operation operations" "pub enum Operation { Start(String), }"
    generate memory
    expect "Memory" "$reply" "Generated.[ @work/gen/memory/memory.rs ]"
    expect_item "Memory record types" "pub struct Record { pub string: String, pub integer: i64, }"
    generate other-root
    expect "a fifth head" "$reply" "Rejected.{ @/other-root.ethos { 1 1 } Conceptual.{ [ 0 ] Root } }"
  '';
}
