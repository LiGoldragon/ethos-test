# A variant declares its payload in place: a vector is carried as the vector,
# a struct as a full type with a derived name. rustc accepts the result.
# Target: pass.
{
  pkgs,
  flake,
  system,
  ...
}:
flake.lib.ethosScenario { inherit pkgs flake system; } {
  name = "ethos-zero-cargo-variant-inline";
  statement = "A variant may declare its payload inline";
  target = "pass";
  script = ''
    generate variant
    expect "variant" "$reply" "Generated.[ @work/gen/variant/variant.rs ]"
    expect_item "the derived struct" "pub struct Unwritable_Data { pub file_path: FilePath, pub string: String, }"
    expect_item "the enum" "pub enum GenerationFailure { SyntaxError(std::vec::Vec<FilePath>), Unwritable(Unwritable_Data), }"
    compiles "with datom" datom "$rust" 'fn main() { let _ = GenerationFailure::SyntaxError(Vec::new()); }'
  '';
}
