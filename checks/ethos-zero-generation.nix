# ethos-zero is asked Generate.{ /abs/file.ethos /abs/out } and answers
# Generated with the path of the file it wrote, the Rust module of the
# same name.
# Target: pass.
{
  pkgs,
  flake,
  system,
  ...
}:
flake.lib.ethosScenario { inherit pkgs flake system; } {
  name = "ethos-zero-generation";
  statement = "Generation";
  target = "pass";
  script = ''
    generate orchestrate
    expect "Generate" "$reply" "Generated.[ @work/gen/orchestrate/orchestrate.rs ]"
    [ -s "$rust" ] || miss "Generate answered, but wrote no file"
    step "the written file" "$(wc -l <"$rust") lines"
  '';
}
