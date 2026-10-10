# FlowId.String and Age.Integer each generate a struct of one unnamed public
# position, bearing the derive every struct bears; rustc accepts it.
# Target: ruled.
{
  pkgs,
  flake,
  system,
  ...
}:
flake.lib.ethosScenario { inherit pkgs flake system; } {
  name = "ethos-zero-cargo-newtype";
  statement = "Ethos-solution item 1: A declaration Name.Type is a new type, not an alias";
  target = "ruled";
  script = ''
    generate newtype
    expect "newtype" "$reply" "Generated.[ @work/gen/newtype/newtype.rs ]"
    header='#[rustfmt::skip] #[derive(rkyv::Archive, rkyv::Serialize, rkyv::Deserialize, Clone, Debug, PartialEq, Eq, Hash)] #[cfg_attr(feature = "datom", derive(datom_codec::Datomizable, datom_codec::Composing))]'
    expect_item "FlowId" "$header pub struct FlowId(pub String);"
    expect_item "Age" "$header pub struct Age(pub i64);"
    compiles "with datom" datom "$rust" 'fn main() { let _ = (FlowId("abc123".to_owned()), Age(7)); }'
  '';
}
