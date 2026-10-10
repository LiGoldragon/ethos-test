# Statements

Every statement of psyche-skills `vision/ethos.md` at 850fd27, and every
ruled item of d5df1d's ethos solution (`flows/d5df1d/reports/ethos-solution.md`
in Primary), mapped to the check that tests it, or to the reason it has none.
Line numbers are those of `vision/ethos.md` at 850fd27. The checks run
ethos-zero as `flake.lock` pins it (07714b0).

The categories:

- **pass**: a check that must meet every expectation today.
- **ruled**: an expected-failing target: ruled, not yet landed in the pinned
  ethos-zero. It builds while it misses and fails when it passes, to be
  promoted to `pass`.
- **fixture**: built and asserted to generate, nothing more.
- **differs**: the vision's text and ethos-zero disagree, or the vision
  disagrees with itself or with a later ruling; no target until the living
  rules. Each carries what was measured.
- **no observable**: the statement names no form accepted or refused, no Rust
  emission, and no datom print or parse of ethos-zero. Not executable.
- **unruled**: rests on a proposal or fork the living has not ruled. No check
  or target in any state.

## vision/ethos.md

| lines | statement | category | check | what it asserts, or why none |
|---|---|---|---|---|
| 6-8 | Flow, a current best example | fixture | ethos-zero-flow-example | ethos-zero 07714b's own four Flow fixtures (fixtures/print/flow-*.ethos) generate |
| 10-36 | Where the golden ethos lives | no observable | | where documents live |
| 40-45 | What Ethos is | no observable | | the meaning and centrality of ethos |
| 49-53 | Why Ethos | no observable | | purpose and comparison with other languages |
| 57, 62 | Roots: four roots, what each declares | pass | ethos-zero-roots | the four roots read; Signal yields Query and Response, Operation an Operation type, Memory its record types; another head refused `Root` |
| 57 | Roots: no version in a file | pass | ethos-zero-file | a version before the sections is refused, whole reply asserted |
| 57-60 | Roots: Signal's sections are queries and responses; Sema's are record types; Signal gives a Nexus its main types and Sema its database types | pass (Signal), no observable (Nexus and Sema roles) | ethos-zero-roots | Query and Response from the first two sections; what a Nexus or Sema does with the types is outside ethos-zero |
| 62 | Roots: a memory trait carries the change and the per-version upgrade | no observable | | no ethos form for an upgrade is given |
| 66-67 | Non-repetition | no observable | | a law of design, not a form |
| 69 | Terseness is in the low amount of noise, never in shortened words | no observable | | a judgement of style |
| 73-75 | Self-description: the CLI help emits the ethos of the object's anatomy | pass | ethos-zero-self-description | the no-argument print equals the literal anatomy, `Check` accepts it, and the requests and replies it declares are the ones the CLI takes and gives |
| 75-78 | Self-description: Mentci later; two audiences | no observable | | horizon and purpose |
| 82-85 | Horizon | no observable | | the future of the language |
| 89-90 | Trait: the word, and the bearer of capabilities | no observable | | vocabulary; the landed `trait` word is in every `TraitWanted` reply |
| 90-92 | Trait: no generics, only traits; a declared trait is a Rust trait | pass | ethos-zero-cargo-trait | a trait in an input becomes a bounded method parameter; rustc accepts the trait and an interaction |
| 92 | Trait: "might imply more in the ethos world" | no observable | | open-ended |
| 94 | Trait: a concrete type in an input is a trait not yet named | pass, the generator's reading | ethos-zero-trait-concrete-input | String in an input refused `TraitWanted.String` |
| 98-104 | Naming | no observable | | qualifier versus verb is a judgement of English |
| 106-110 | Identity: the head is the name and its constraints; a constraint is a trait or a bracket of traits | pass | ethos-zero-cargo-identity | one generic parameter per constraint, a bracket as `+` bounds; rustc accepts the trait and an interaction, the constraints imported from the harness crate |
| 111 | Identity: a constraint in a trait declaration is a trait, never a type | pass, the generator's reading | ethos-zero-trait-concrete-input | the concrete-type refusal is the one observable of it |
| 111-112 | Identity: two heads that differ in a constraint are two traits | differs: tension within the vision | | measured: `Rejected.{ @/two-heads.ethos { 5 3 } Conceptual.{ [ 1 2 1 0 ] Duplicate.Processable } }`; Rust holds one trait per name, so the line meets the vision's own "the ethos compiles to Rust". A fork for the living's next ethos book: distinct generated names, or amend the line |
| 112-116 | Identity: which constraints belong is not a decision; the rest is the definition | no observable | | a statement of method |
| 116-118 | Identity: angle brackets hold the constraints, a protos delimiter recycled from Rust | pass | ethos-zero-cargo-identity | the head is written with angle brackets and read |
| 119-136 | Identity: the example | differs | | `std:[ Clonable Sendable Serializable ]` emits `std::Clonable`, `std::Sendable`, `std::Serializable`, which rustc does not resolve; the example's Rust shows `Clone`, `Send`, `Serialize`. An import source is one segment: `std:clone:Clonable.Clone` is refused `Expected.Import` |
| 139-140 | Declaration: File: one file, one Rust module; no namespace inside a file | pass | ethos-zero-generation | one ethos file generates one Rust module of its name |
| 140-145 | Declaration: File: the sweet form, converted mechanically to the canonical | pass | ethos-zero-file | sweet and braced forms generate the same Rust |
| 148-149 | Declaration: File: no version | pass | ethos-zero-file | see line 57 |
| 151-153 | Declaration: File: a Library's sections in order; every root's first section is its imports | pass | ethos-zero-imports, ethos-zero-cargo-associations, ethos-zero-roots | imports, types, traits and associations each read in place |
| 174-177 | Imports: a source and a type, singly or bracketed; the intrinsics need no import | pass | ethos-zero-imports | |
| 175-176 | Imports: an explicit import and an intrinsic name mean the same thing | ruled | ethos-zero-cargo-imports-intrinsic | a defect for Mind: `protos:String` emits `pub string: protos::String`, which rustc refuses (`error[E0425]: cannot find type String in crate protos`); it is to emit what `String` emits |
| 187-189 | Imports: no use statements; each imported name fully qualified | pass | ethos-zero-imports | `datom::Datom`, `protos::Textualizable`, and no `use`. Line 188's `protos::String` is consistent with 175-176 only if protos provides `String`; the ruled target above asks that the result is the intrinsic, however written |
| 193-197 | What a declaration turns into: named fields, the derive, field names | pass | ethos-zero-cargo-declaration | `string_vector`, `lock_option`, `first_string`/`second_string`; rustc accepts with and without datom |
| 210-211 | What a declaration turns into: `pub type LockId = Integer;` and its siblings | differs until the living rules the types book | | the alias lines at 210-211, 237-238, 265-266, 290, 306-307 and 354-356 show aliases; the new-type targets stand on the 2026-10-06 record |
| 220-225 | Inline types: a full type whose derived name carries an underscore, so it never collides | pass | ethos-zero-cargo-inline, ethos-zero-cargo-inline-collision | `PathOverlap_Data`; two enums' inline `X` become `P_X_Data` and `Q_X_Data`; an authored name equal to a derived one is refused `Duplicate` |
| 247 | Inline types: everything is a type; used once inline, used twice named; the payload bears the variant's name; about three deep | no observable | | how often a type is used and how deep nesting goes are the author's choices; the payload's derived name is asserted by ethos-zero-cargo-inline |
| 249-268 | A variant named as a defined type carries that type | pass | ethos-zero-cargo-variant-defined | `SyntaxError(SyntaxError)`, `Unwritable`; the variant's datom `SyntaxError.[ /abs/orchestrate.ethos ]` read as that variant and printed back |
| 268 | A variant named as a defined type: the datom `GenerationFailure.SyntaxError.[ /abs/orchestrate.ethos ]` | differs | | measured: datom-codec 4dff16b refuses it, `Variant { expected: "GenerationFailure", found: "GenerationFailure" }`; a datom carries no type name |
| 276-279 | A variant may declare its payload inline, recursively | pass | ethos-zero-cargo-variant-inline, ethos-zero-cargo-inline-recursive | the vector carried as the vector; `Unwritable_Data`; an inline enum holding an inline struct, `Io_Data_Refused_Data` |
| 297-302 | Every declared type bears both traits | pass | ethos-zero-cargo-derives | every struct and enum, inline payloads included, carries the derive; an alias carries none; rustc confirms each bears both. It asserts the code's name, `Composing` |
| 299 | Every declared type bears both traits: the name `Compositional` | differs | | the vision says `Compositional`, the code emits `Composing`; fixed by invariants Proposal 6 |
| 312-316 | The datom traits are compiled in only where text is spoken | pass | ethos-zero-cargo-datom-feature | the gated derive; rustc accepts with no datom-codec at all, and with the feature the types bear both. It asserts `Composing` |
| 333-337 | Shapes and placement | pass | ethos-zero-cargo-signal | queries and responses as variants of Query and Response; a bracket among types is an enum |
| 338-339 | Shapes and placement: default implementations for Query and Response | no observable | | "may generate" |
| 361-364 | Traits are explicit; bodies are hand-written | pass | ethos-zero-cargo-trait-explicit | the assertion is emitted; rustc accepts with the hand-written body and refuses E0277 without |
| 385-389 | Trait syntax: a simple trait, receivers, inputs and yield; a yield bracket holds one type | pass | ethos-zero-cargo-trait-simple | `.` `!` `:` receivers and a headed brace of inputs and yield, each yield one type; rustc accepts an interaction |
| 394 | Trait syntax: the example `push!{ [ String ] … }` | differs: a stale example | | measured: `Rejected.{ @/fillable.ethos { 4 23 } Conceptual.{ [ 1 2 0 1 0 1 0 0 ] TraitWanted.String } }`. Proposed one-line fix: `String` replaced by `Self` |
| 410-413 | Trait syntax: a complex trait | pass | ethos-zero-cargo-trait-complex | supertraits, an associated type with its constraint, an upper-case constant, a capability; rustc accepts an interaction |
| 410-428 | Trait syntax: the complex example's `std:Serializable` | differs | | emits `std::Serializable`, which rustc does not resolve |
| 440-444 | Associations: a type's name, a dot, its traits; the fourth section of a Library | pass | ethos-zero-cargo-associations | both assertions; rustc refuses E0277 when one trait is missing |
| 441-443 | Associations: implied in Signal and Sema, never written | pass | ethos-zero-cargo-signal-associations | a Signal with no associations: rustc confirms Query, Response and its types bear Archive and the datom traits |
| 464-465 | Associations: interactions use the type itself | no observable | | hand-written Rust |
| 467-468 | No tuple in the code we design | pass | ethos-zero-no-tuple | a two-position variant carries a named struct, never a tuple variant |
| 467-468 | No tuple, against the ruled `FlowId(pub String)` | differs: tension for the living | | a new type as a tuple struct is a tuple in the code we design; beside types Fork 4. No target |
| 472-474 | Spacing: delimiters spaced, the canonical protos print | pass | ethos-zero-spacing | on the CLI's own print: a space inside brackets, `[]` empty, elements hanging aligned, the closer on the last element's line |
| 476 | Spacing: every structure of more than one element opens vertically; nothing with a next layer on one line | differs | | `Unreadable.{ String String }` prints on one line in the CLI's own print |
| 478 | Spacing: a comment on every section and layered line | no observable | | a rule of authorship; the print drops comments (invariants Proposal 3, unruled) |
| 482-484 | Zero | no observable | | the name's history and the future repository |
| 488-492 | Generation | pass | ethos-zero-generation | `Generate.{ file out }` answers `Generated.[ out/<name>.rs ]` and writes it |
| 488 | Generation: committed, held fresh by a test | no observable | | the consumer's repository practice |
| 494-541 | Sources | no observable | | provenance; no target rests on it |

## Ruled items of the ethos solution

| item | ruling | category | check |
|---|---|---|---|
| 1. A declaration `Name.Type` is a new type | d4ae97 vision/ethos.md, "Newtypes, not type aliases", 2026-10-06 | ruled | ethos-zero-cargo-newtype, ethos-zero-cargo-newtype-distinct |
| 2. A struct of one position is refused | d4ae97 vision/ethos.md, "A one-position type is called a new type", 2026-10-06 | ruled | ethos-zero-single-position, ethos-zero-single-position-inline |
| 3. The inline import `Topic.custom:Name` | d5df1d vision/ethos.md, choice 3, 2026-10-09 | pass | ethos-zero-inline-import |
| 5. `kind` to `trait` | d5df1d vision/ethos.md, "Trait: rename every place", 2026-10-09 | pass | the `TraitWanted` reply in ethos-zero-trait-concrete-input |
| 6. Flow's `FlowId.String`, with its comment | as item 1 | ruled | ethos-zero-cargo-flow-id |
| 8. Implementers report what is hard to express | ebbe30 vision/ethos.md, 2026-10-09 | no observable | a rule of conduct for implementers |

The new-type targets assert a struct and not an alias, and the distinctness
rustc gives it; the inner position's form is types Fork 4, not asserted. The
refusal name `SinglePosition` is the design's own (ethos-solution item 2).

## Unruled, no target

- Types Fork 1: a name over a container.
- Types Fork 2: a name over a declared type.
- Types Fork 3: the datom of a new type.
- Types Fork 4: how the value inside a new type is reached.
- Types Fork 5: every semantic string a new type.
- The double-wrap refusal.
- The refusal of a new type over a struct or enum.
- Invariants Proposal 3: the print keeps every comment.
- Invariants Proposal 4: each element on a new indented line.
- Invariants Proposal 5: implementers report, kept or amended.
- Invariants Proposal 6: the derive's name in the skill text.
- Invariants Fork 1: how deep a type is declared inline.
- Invariants Fork 2: who holds layout and comments.
- Invariants Fork 3: a Mutex field.
- The special representation.
- The inline-import research questions, `core:Name` among them (item 7).
- A lowercase variant name refused (item 4d).
- Any Sources-list behaviour.
