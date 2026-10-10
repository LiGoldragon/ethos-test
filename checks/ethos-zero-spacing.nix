# The canonical print (the CLI's own ethos, printed with no argument):
# a space inside every non-empty bracket, [] empty; elements hang aligned
# beneath the first, and the closer ends the last element's line.
# Target: pass.
{
  pkgs,
  flake,
  system,
  ...
}:
flake.lib.ethosScenario { inherit pkgs flake system; } {
  name = "ethos-zero-spacing";
  statement = "Spacing";
  target = "pass";
  script = ''
    printed=$(ethos-zero)
    step "no argument" "$(printf '%s' "$printed" | head -c 200 | tr '\n' ' ')"
    expect_contains "hanging, aligned, closed on the last line" "$printed" "  Response.[ Generated.Vector<String>
                 Checked.String"
    expect_contains "an empty section" "$printed" "
    []
    []"
  '';
}
