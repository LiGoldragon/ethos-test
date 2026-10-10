# A declaration turns into a Rust type with named fields, bearing the datom
# traits through the derive. A field is named after its type in snake case;
# a constructed type type-first (string_vector, lock_option); a repeated type
# as first and second. rustc accepts the result with and without datom.
# Target: pass.
{
  pkgs,
  flake,
  system,
  ...
}:
flake.lib.ethosScenario { inherit pkgs flake system; } {
  name = "ethos-zero-cargo-declaration";
  statement = "What a declaration turns into";
  target = "pass";
  script = ''
    generate declaration
    expect "declaration" "$reply" "Generated.[ @work/gen/declaration/declaration.rs ]"
    expect_item "fields named after their types" "pub struct Lock { pub lock_id: LockId, pub lock_name: LockName, pub string_vector: std::vec::Vec<String>, #[rkyv(omit_bounds)] pub lock_option: std::option::Option<std::boxed::Box<Lock>>, }"
    expect_item "a repeated type as first and second" "pub struct Generation { pub first_string: String, pub second_string: String, }"
    expect_item "the derive" '#[cfg_attr(feature = "datom", derive(datom_codec::Datomizable, datom_codec::Composing))] pub struct Generation'
    main='fn main() { let _ = Generation { first_string: String::new(), second_string: String::new() }; }'
    compiles "without datom" "" "$rust" "$main"
    compiles "with datom" datom "$rust" "$main"
  '';
}
