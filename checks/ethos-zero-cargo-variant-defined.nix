# GenerationFailure.[ SyntaxError Unwritable ] with SyntaxError a defined
# type: the variant SyntaxError carries a SyntaxError, Unwritable carries
# nothing. The variant's datom, SyntaxError.[ /abs/orchestrate.ethos ], is
# read as that variant and printed back.
# Target: pass.
{
  pkgs,
  flake,
  system,
  ...
}:
flake.lib.ethosScenario { inherit pkgs flake system; } {
  name = "ethos-zero-cargo-variant-defined";
  statement = "A variant named as a defined type carries that type";
  target = "pass";
  script = ''
    generate variant
    expect "variant" "$reply" "Generated.[ @work/gen/variant/variant.rs ]"
    expect_item "the enum" "pub enum GenerationFailure { SyntaxError(SyntaxError), Unwritable, }"
    main=$(cat <<'RS'
    use datom_codec::{Actualizing, Budget, Datomizable, Path, Potential};
    use protos::{Protosizable, ReaderBudget, Textualizable};
    fn main() {
        let text = "SyntaxError.[ /abs/orchestrate.ethos ]";
        let mut budget = Budget {
            remaining: 4_096,
            reader: ReaderBudget { remaining: 4_096 },
            depth: 0,
            maximum_depth: 4_096,
        };
        match Potential::<GenerationFailure>::from(text).actualize(&mut budget) {
            Ok(value @ GenerationFailure::SyntaxError(_)) => {
                println!("{}", value.datomize(Path::new()).protosize().textualize())
            }
            Ok(other) => println!("read as another variant: {other:?}"),
            Err(error) => println!("refused: {error:?}"),
        }
    }
    RS
    )
    runs "the variant's datom" datom "$rust" "$main"
    expect "the variant's datom, read and printed" "$printed" "SyntaxError.[ /abs/orchestrate.ethos ]"
  '';
}
