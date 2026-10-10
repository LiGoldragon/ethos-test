# "An explicit import and an intrinsic name mean the same thing": a Record
# whose String is imported from protos is the Record whose String is the
# intrinsic; rustc accepts it and it holds a std String. A defect for Mind:
# protos:String is to emit what String emits.
# Target: ruled.
{
  pkgs,
  flake,
  system,
  ...
}:
flake.lib.ethosScenario { inherit pkgs flake system; } {
  name = "ethos-zero-cargo-imports-intrinsic";
  statement = "Imports";
  target = "ruled";
  script = ''
    generate imported
    expect "imported" "$reply" "Generated.[ @work/gen/imported/imported.rs ]"
    compiles "the imported String is the intrinsic" datom "$rust" 'fn main() { let _ = Record { string: String::from("a"), integer: 1 }; }'
  '';
}
