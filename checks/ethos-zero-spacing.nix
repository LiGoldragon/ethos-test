# The canonical print (the CLI's own ethos, printed with no argument):
# a space inside every non-empty bracket and brace, [] empty; a structure
# with an element that has a next layer opens on its line, its elements
# hang aligned beneath the first, and the closer ends the last line.
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
    expect_contains "a space inside a brace" "$printed" "Unreadable.{ String String }"
    expect_contains "an empty section" "$printed" "
    []
    []"
  '';
}
