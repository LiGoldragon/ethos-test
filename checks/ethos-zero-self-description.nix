# With no argument, the CLI prints the ethos that describes its own anatomy:
# the output is itself ethos that ethos-zero accepts, and it declares the
# two requests the CLI takes.
# Target: pass.
{
  pkgs,
  flake,
  system,
  ...
}:
flake.lib.ethosScenario { inherit pkgs flake system; } {
  name = "ethos-zero-self-description";
  statement = "Self-description";
  target = "pass";
  script = ''
    ethos-zero >"$work/self.ethos"
    step "no argument" "$(head -c 200 "$work/self.ethos" | tr '\n' ' ')"
    reply=$(answered "$(ethos-zero "Check.$work/self.ethos" 2>&1 || true)")
    expect "its own print, checked" "$reply" "Checked.@work/self.ethos"
    expect_contains "the requests" "$(cat "$work/self.ethos")" "[ Query.[ Generate.Generation
              Check.String ]"
  '';
}
