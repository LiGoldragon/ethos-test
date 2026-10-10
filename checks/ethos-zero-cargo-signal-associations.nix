# "In the Signal and Sema roots the associations of the query, response and
# record types are implied and never written": a Signal written with no
# associations yields Query, Response and its types already bearing what
# every declared type bears; rustc confirms rkyv's Archive and the datom
# traits on each.
# Target: pass.
{
  pkgs,
  flake,
  system,
  ...
}:
flake.lib.ethosScenario { inherit pkgs flake system; } {
  name = "ethos-zero-cargo-signal-associations";
  statement = "Associations";
  target = "pass";
  script = ''
    generate signal
    expect "signal" "$reply" "Generated.[ @work/gen/signal/signal.rs ]"
    main=$(cat <<'RS'
    fn bears<T: rkyv::Archive + datom_codec::Datomizable + datom_codec::Composing>() {}
    fn main() {
        bears::<Query>();
        bears::<Response>();
        bears::<LockRequest>();
    }
    RS
    )
    compiles "implied, never written" datom "$rust" "$main"
  '';
}
