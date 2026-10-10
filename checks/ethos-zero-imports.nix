# An import names a source and a type, singly or as a bracket. The
# generated code carries no use statement: each imported name is written
# fully qualified, datom:Datom as datom::Datom and protos:Textualizable as
# protos::Textualizable. The intrinsic names need no import.
# Target: pass.
{
  pkgs,
  flake,
  system,
  ...
}:
flake.lib.ethosScenario { inherit pkgs flake system; } {
  name = "ethos-zero-imports";
  statement = "Imports";
  target = "pass";
  script = ''
    generate imports
    expect "imports" "$reply" "Generated.[ @work/gen/imports/imports.rs ]"
    expect_item "datom:Datom, fully qualified" "pub struct Holder { pub datom: datom::Datom, pub integer: i64, }"
    expect_item "protos:Textualizable, fully qualified" "fn resolve<N: protos::Textualizable>(&self, input: N) -> Self"
    if grep -q -E '^[[:space:]]*(pub )?use ' "$rust"; then miss "the generated Rust carries a use statement"; fi
    step "imports" "no use statement"
    check intrinsics
    expect "the intrinsics, unimported" "$reply" "Checked.@/intrinsics.ethos"
  '';
}
