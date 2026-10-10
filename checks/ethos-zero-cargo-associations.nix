# Sink.[ Summarizable Fillable ] asserts both traits: rustc accepts the file
# when Sink bears both, and refuses it (E0277) when Sink bears only one.
# Target: pass.
{
  pkgs,
  flake,
  system,
  ...
}:
flake.lib.ethosScenario { inherit pkgs flake system; } {
  name = "ethos-zero-cargo-associations";
  statement = "Associations";
  target = "pass";
  script = ''
    generate sink
    expect "sink" "$reply" "Generated.[ @work/gen/sink/sink.rs ]"
    expect_item "two assertions" "const _: () = { fn assert_sink_summarizable<T: Summarizable>() {} let _ = assert_sink_summarizable::<Sink>; fn assert_sink_fillable<T: Fillable>() {} let _ = assert_sink_fillable::<Sink>; };"
    summarizable='impl Summarizable for Sink { fn summarize(&self) -> String { self.string.clone() } }'
    fillable='impl Fillable for Sink { fn create() -> Self { Sink { string: String::new(), integer: 0 } } }'
    compiles "bearing both" datom "$rust" "$summarizable $fillable fn main() {}"
    refused_by_rustc "bearing one" datom "$rust" "$summarizable fn main() {}" E0277
  '';
}
