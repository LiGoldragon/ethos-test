# A signal library bears Datomizable and Composing under the datom feature.
# Without the feature the harness has no datom-codec at all, and rustc
# accepts the same generated Rust; with it, the types bear both traits.
# It asserts the code's derive name, Composing, not the vision's Compositional.
# Target: pass.
{
  pkgs,
  flake,
  system,
  ...
}:
flake.lib.ethosScenario { inherit pkgs flake system; } {
  name = "ethos-zero-cargo-datom-feature";
  statement = "The datom traits are compiled in only where text is spoken";
  target = "pass";
  script = ''
    generate signal
    expect "signal" "$reply" "Generated.[ @work/gen/signal/signal.rs ]"
    expect_item "the gated derive" '#[cfg_attr(feature = "datom", derive(datom_codec::Datomizable, datom_codec::Composing))] pub enum Query'
    compiles "the Nexus, no datom-codec" "" "$rust" 'fn main() { let _ = Query::Release(7); }'
    compiles "the CLI, datom" datom "$rust" 'fn bears<T: datom_codec::Datomizable + datom_codec::Composing>() {} fn main() { bears::<Query>(); bears::<Response>(); }'
  '';
}
