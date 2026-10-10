# Every generated struct and enum, an inline payload's included, carries the
# derive; an alias carries none and bears the traits through the type it
# names. rustc confirms each type bears Datomizable and Composing.
# It asserts the code's derive name, Composing, not the vision's Compositional.
# Target: pass.
{
  pkgs,
  flake,
  system,
  ...
}:
flake.lib.ethosScenario { inherit pkgs flake system; } {
  name = "ethos-zero-cargo-derives";
  statement = "Every declared type bears both traits";
  target = "pass";
  script = ''
    generate derives
    expect "derives" "$reply" "Generated.[ @work/gen/derives/derives.rs ]"
    header='#[rustfmt::skip] #[derive(rkyv::Archive, rkyv::Serialize, rkyv::Deserialize, Clone, Debug, PartialEq, Eq, Hash)] #[cfg_attr(feature = "datom", derive(datom_codec::Datomizable, datom_codec::Composing))]'
    expect_item "the enum" "$header pub enum Rank"
    expect_item "the struct" "$header pub struct Record"
    expect_item "the inline payload" "$header pub struct Started_Data"
    expect_item "the enum holding it" "$header pub enum Event"
    expect_item "the alias, no derive" "#[rustfmt::skip] pub type Names = std::vec::Vec<String>;"
    main=$(cat <<'RS'
    fn bears<T: datom_codec::Datomizable + datom_codec::Composing>() {}
    fn main() {
        bears::<Names>();
        bears::<Rank>();
        bears::<Record>();
        bears::<Started_Data>();
        bears::<Event>();
    }
    RS
    )
    compiles "every type bears both" datom "$rust" "$main"
  '';
}
