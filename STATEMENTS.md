# Statements

Every statement of psyche-skills `vision/ethos.md` at 850fd27, and every
ruled item of d5df1d's ethos solution (`flows/d5df1d/reports/ethos-solution.md`
in Primary), mapped to the check that tests it, or to the reason it has none.
The checks run ethos-zero as `flake.lock` pins it (07714b0).

The categories:

- **pass**: a check that must meet every expectation today.
- **ruled**: an expected-failing target: ruled, not yet landed in the pinned
  ethos-zero. It builds while it misses and fails when it passes, to be
  promoted to `pass`.
- **fixture**: built and asserted to generate, nothing more.
- **no observable**: the statement names no form accepted or refused, no Rust
  emission, and no datom print or parse of ethos-zero. Not executable.
- **unruled, no target**: rests on a proposal or fork the living has not
  ruled. No check or target in any state.
- **differs, no target**: the statement names an observable that ethos-zero
  07714b does not meet, and the behaviour is not among the ruled items being
  landed, so it is neither a passing check nor an expected-failing target.
  Each carries the observation, for the design owner's judgement.

## vision/ethos.md

| heading | category | check | what it asserts, or why none |
|---|---|---|---|
| Flow, a current best example | fixture | ethos-zero-flow-example | the four Flow files (ethos-zero 07714b fixtures/print/flow-*.ethos) generate. The vision-flow-ethos skill it names does not exist at 850fd27. |
| Where the golden ethos lives | no observable | | where documents live; the graph names skills, not behaviour |
| What Ethos is | no observable | | the meaning and centrality of ethos |
| Why Ethos | no observable | | purpose and comparison with other languages |
| Roots | pass | ethos-zero-roots | Library, Signal, Operation, Memory read; Query/Response and Operation/Outcome generated; another head refused `Root`; `Sema` refused `Renamed.Memory` |
| Roots: a memory trait carries the change and per-version upgrade | no observable | | no ethos form for an upgrade is given; nothing to accept or refuse |
| Non-repetition | no observable | | a law of design ("any repetition is an implementation failure"), not a form |
| Self-description | pass | ethos-zero-self-description | the no-argument print is ethos that `Check` accepts and declares the CLI's requests. Pointing at any object (Mentci) is a horizon, no observable |
| Horizon | no observable | | the future of the language |
| Trait | pass | ethos-zero-trait | a concrete type in an input is refused `TraitWanted.String`; a trait in an input becomes a bounded method parameter |
| Trait: the word, and trait as the bearer of capabilities | no observable | | vocabulary; the landed trait word (item 5) is asserted by the `TraitWanted` reply above |
| Naming | no observable | | qualifier versus verb is a judgement of English, not a mechanical form |
| Identity | pass | ethos-zero-identity, ethos-zero-cargo-identity | the head becomes one generic parameter per constraint, a bracket as `+` bounds; with resolvable traits rustc accepts an interaction |
| Identity: two heads differing in a constraint are two traits | differs, no target | | `Processable<Clonable>` beside `Processable<Sendable>` is refused, measured: `Rejected.{ @/two-heads.ethos { 5 3 } Conceptual.{ [ 1 2 1 0 ] Duplicate.Processable } }`. Why: the checking pass refuses a second declaration of one name, and Rust holds one trait per name in a module, so the statement names no Rust emission either |
| Identity: the example's Rust | differs, no target | | `std:[ Clonable Sendable Serializable ]` emits `std::Clonable`, `std::Sendable`, `std::Serializable`, which rustc does not resolve; the vision shows `Clone`, `Send`, `Serialize`. The check asserts the emitted head's shape, and the cargo variant imports its constraints from the harness crate (`bounds:`), since an import source is one segment and `std:clone:Clonable.Clone` is refused `Expected.Import` |
| Declaration: File | pass | ethos-zero-file | sweet and braced forms generate the same Rust; a version written in the file is refused |
| Imports | pass | ethos-zero-imports | imported names fully qualified, no `use`; the intrinsics read without import |
| Imports: an explicit import and an intrinsic name mean the same | differs, no target | | `protos:String` emits `pub string: protos::String`, the intrinsic emits `pub string: String`. Measured: rustc refuses the generated file, `error[E0425]: cannot find type String in crate protos`; protos 15b41da exports no `String` |
| What a declaration turns into | pass | ethos-zero-cargo-declaration | named fields after their types: `string_vector`, `lock_option`, `first_string`/`second_string`; the derive; rustc accepts with and without datom |
| What a declaration turns into: `LockId.Integer` as `pub type LockId = Integer;` | differs from the ruled target | ethos-zero-cargo-newtype (ruled) | the vision's example shows an alias for a name over a plain value; the ruled target is a new type. Not asserted as an alias. The vision's `Option<Lock>` is emitted boxed, as Rust requires for a recursive field |
| Inline types | pass | ethos-zero-cargo-inline | `PathOverlap_Data`, named for its variant; rustc accepts |
| Inline types: everything is a type, used once inline, used twice named | no observable | | how often a type is used is the author's choice; no form refuses it |
| Inline types: nesting about three deep | unruled, no target | | invariants Fork 1 |
| A variant named as a defined type carries that type | pass | ethos-zero-cargo-variant-defined | `SyntaxError(SyntaxError)`, `Unwritable`; the variant's datom `SyntaxError.[ /abs/orchestrate.ethos ]` read as that variant and printed back |
| A variant named as a defined type: the datom `GenerationFailure.SyntaxError.[ /abs/orchestrate.ethos ]` | differs, no target | | datom-codec 4dff16b refuses it as a `GenerationFailure`: `Variant { expected: "GenerationFailure", found: "GenerationFailure" }`; the type's name is not part of its datom. Whether the vision's line shows the type for context or as the datom is the design owner's to judge |
| A variant may declare its payload inline | pass | ethos-zero-cargo-variant-inline | the vector carried as the vector, the struct as `Unwritable_Data`; rustc accepts |
| Every declared type bears both traits | pass | ethos-zero-cargo-derives | every struct and enum, inline payloads included, carries the derive; an alias carries none; rustc confirms each bears both |
| Every declared type bears both traits: the name `Compositional` | unruled, no target | | ethos-zero emits `Composing`; the rename is invariants Proposal 6 |
| The datom traits are compiled in only where text is spoken | pass | ethos-zero-cargo-datom-feature | the gated derive; rustc accepts with no datom-codec at all, and with the feature the types bear both |
| Shapes and placement | pass | ethos-zero-cargo-signal | queries and responses as variants of Query and Response; a bracket among types is an enum |
| Shapes and placement: default implementations for Query and Response | no observable | | "may generate": no behaviour is required |
| Traits are explicit; bodies are hand-written | pass | ethos-zero-cargo-trait-explicit | the assertion is emitted; rustc accepts with the hand-written body and refuses E0277 without |
| Trait syntax | pass | ethos-zero-cargo-trait-simple, ethos-zero-trait-complex, ethos-zero-cargo-trait-complex | receivers `.` `!` `:`, inputs and yield; the complex trait as given; with a resolvable constraint rustc accepts an interaction |
| Trait syntax: the example `push!{ [ String ] … }` | differs, no target | | refused, measured: `Rejected.{ @/fillable.ethos { 4 23 } Conceptual.{ [ 1 2 0 1 0 1 0 0 ] TraitWanted.String } }`. Why: the Trait section's line "a concrete type in an input is a trait not yet named" refuses it; the two sections of the vision disagree. The check uses `Self` as the input |
| Associations | pass | ethos-zero-cargo-associations, ethos-zero-signal-associations, ethos-zero-no-tuple | both assertions; rustc refuses E0277 when one trait is missing; a Signal with an associations section is refused; a two-position variant is a named struct, not a tuple |
| Associations: interactions use the type itself | no observable | | hand-written Rust, outside the generator |
| Spacing | pass | ethos-zero-spacing | on the CLI's own print: a space inside brackets and braces, `[]` empty, elements hanging aligned, the closer on the last line |
| Spacing: every structure of more than one element opens vertically | unruled, no target | | `Unreadable.{ String String }` prints on one line; the layout is invariants Proposal 4 |
| Spacing: a comment on every section and layered line | unruled, no target | | the print drops comments; invariants Proposal 3 and Fork 2 |
| Zero | no observable | | the name's history and the future repository |
| Generation | pass | ethos-zero-generation | `Generate.{ file out }` answers `Generated.[ out/<name>.rs ]` and writes it |
| Generation: committed, held fresh by a test | no observable | | the consumer's repository practice |
| Sources | no observable | | provenance |

## Ruled items of the ethos solution

| item | category | check |
|---|---|---|
| 1. A declaration `Name.Type` is a new type, not an alias | ruled | ethos-zero-cargo-newtype, ethos-zero-cargo-newtype-distinct |
| 2. Single-field structs are refused | ruled | ethos-zero-single-position, ethos-zero-single-position-inline |
| 3. The inline import `Topic.custom:Name` (choice 3, ruled 2026-10-09) | pass | ethos-zero-inline-import |
| 5. `kind` to `trait` (the golden ethos, Ruling 2) | pass | the `TraitWanted` reply in ethos-zero-trait |
| 6. Flow's `FlowId.String`, with its comment | ruled | ethos-zero-cargo-flow-id |
| 8. Implementers report what is hard to express | no observable | a rule of conduct for implementers, not of ethos-zero |

The refusal name `SinglePosition` is the design's own (ethos-solution item 2);
the books give no message text.

## Unruled, no target

Types Forks 1 to 5 (a name over a container, over a declared type, the datom
of a new type, how the value inside is reached, every semantic string a new
type); the double-wrap and wraps-structure refusals; invariants Proposals 3
to 6 and Forks 1 to 3 (inline depth, who holds layout and comments, a Mutex
field); the special representation; the inline-import research questions and
`core:Name` (item 7); a lowercase variant name (item 4d); and any Sources-list
behaviour.
