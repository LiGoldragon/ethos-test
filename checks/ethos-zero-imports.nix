# An import names a source and a type, singly or as a bracket. The
# generated code carries no use statement: each imported name is written
# fully qualified (datom:Datom as datom::Datom). The intrinsic names need no
# import.
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
    expect_item "an imported name, fully qualified" "pub struct Holder { pub datom: datom::Datom, pub integer: i64, }"
    grep -q -E '^[[:space:]]*(pub )?use ' "$rust" && miss "the generated Rust carries a use statement"
    step "imports" "no use statement"
    check intrinsics
    expect "the intrinsics, unimported" "$reply" "Checked.@/intrinsics.ethos"
  '';
}
