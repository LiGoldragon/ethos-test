# FlowId.String and Age.Integer each generate a new type, a struct bearing
# the derive every struct bears, never an alias; rustc accepts it.
# Target: ruled.
{
  pkgs,
  flake,
  system,
  ...
}:
flake.lib.ethosScenario { inherit pkgs flake system; } {
  name = "ethos-zero-cargo-newtype";
  statement = "Newtypes, not type aliases (d4ae97 vision/ethos.md, 2026-10-06; ethos-solution item 1)";
  target = "ruled";
  script = ''
    generate newtype
    expect "newtype" "$reply" "Generated.[ @work/gen/newtype/newtype.rs ]"
    header='#[rustfmt::skip] #[derive(rkyv::Archive, rkyv::Serialize, rkyv::Deserialize, Clone, Debug, PartialEq, Eq, Hash)] #[cfg_attr(feature = "datom", derive(datom_codec::Datomizable, datom_codec::Composing))]'
    expect_no_item "FlowId, no alias" "pub type FlowId"
    expect_item "FlowId, a struct" "$header pub struct FlowId"
    expect_item "Age, a struct" "$header pub struct Age"
    compiles "with datom" datom "$rust" 'fn main() {}'
  '';
}
