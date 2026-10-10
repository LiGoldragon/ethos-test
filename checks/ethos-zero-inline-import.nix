# Ethos-solution item 3: the inline import Topic.custom:Name is accepted in
# a types section and in a struct position; one source only, told by a
# lowercase first letter and one colon: Topic:custom:Name is refused in both
# positions, Topic:custom.Name is refused, and std:sync:Mutex<String> is
# refused rather than emitting std::Mutex.
# Target: pass.
{
  pkgs,
  flake,
  system,
  ...
}:
flake.lib.ethosScenario { inherit pkgs flake system; } {
  name = "ethos-zero-inline-import";
  statement = "Choice 3 ruled (d5df1d vision/ethos.md, 2026-10-09)";
  target = "pass";
  script = ''
    generate accepted
    expect "Topic.custom:Name" "$reply" "Generated.[ @work/gen/accepted/accepted.rs ]"
    expect_item "in a types section" "pub type Topic = custom::Name;"
    expect_item "in a struct position" "pub struct Holder { pub inner: Inner, pub string: String, }"
    generate struct-position
    expect_prefix "Topic:custom:Name in a struct position" "$reply" "Rejected.{ @/struct-position.ethos "
    generate types-section
    expect_prefix "Topic:custom:Name in a types section" "$reply" "Rejected.{ @/types-section.ethos "
    generate dot-name
    expect_prefix "Topic:custom.Name" "$reply" "Rejected.{ @/dot-name.ethos "
    generate mutex
    expect_prefix "std:sync:Mutex<String>" "$reply" "Rejected.{ @/mutex.ethos "
  '';
}
