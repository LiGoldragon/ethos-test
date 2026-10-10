# "In the Signal and Sema roots the associations of the query, response and
# record types are implied and never written": a Signal has four sections,
# and a fifth, written as associations, is refused.
# Target: pass.
{
  pkgs,
  flake,
  system,
  ...
}:
flake.lib.ethosScenario { inherit pkgs flake system; } {
  name = "ethos-zero-signal-associations";
  statement = "Associations";
  target = "pass";
  script = ''
    generate signal
    expect "an associations section in a Signal" "$reply" "Rejected.{ @/signal.ethos { 1 7 } Conceptual.{ [ 1 ] Arity.{ 4 5 } } }"
  '';
}
