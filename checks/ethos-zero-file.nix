# The sweet form (the head, then the sections as siblings) and the braced
# canonical form read the same: both generate the same Rust. A Library's
# sections are imports, types, traits and associations. A file carries no
# version: a version written before the sections is refused.
# Target: pass.
{
  pkgs,
  flake,
  system,
  ...
}:
flake.lib.ethosScenario { inherit pkgs flake system; } {
  name = "ethos-zero-file";
  statement = "Declaration: File";
  target = "pass";
  script = ''
    generate sweet
    expect "the sweet form" "$reply" "Generated.[ @work/gen/sweet/sweet.rs ]"
    expect_item "the sweet form's type" "pub struct Record { pub string:"
    sweet=$rust
    generate braced
    expect "the braced form" "$reply" "Generated.[ @work/gen/braced/braced.rs ]"
    cmp -s "$sweet" "$rust" || miss "the sweet and braced forms generate different Rust"
    step "sweet and braced" "the same Rust"
    generate version
    expect_prefix "a version in the file" "$reply" "Rejected.{ @/version.ethos "
  '';
}
