# ethos-test

Acceptance checks that run the real `ethos-zero` on ethos fixtures and assert
its reply, the Rust it generates, or what rustc and the built program do with
that Rust. Each check is written to one statement of psyche-skills
`vision/ethos.md` at 850fd27, quoted by its heading, or to a ruled item of
d5df1d's ethos solution. STATEMENTS.md maps every statement to its check, or
says why it has none.

ethos-zero is a flake input whose `nixpkgs` and `rust-build` follow this
flake's; `flake.lock` pins it at 07714b0. Test unpushed ethos-zero code with
`--override-input ethos-zero path:<checkout>`; once it lands,
`nix flake update ethos-zero` and commit the lock.

## Targets

Each scenario declares a target. `pass`: it must meet every expectation.
`ruled`: a ruled behaviour not yet landed in the pinned ethos-zero, expected
to miss. A missed expectation is recorded as expected-failing and the check
builds; a `ruled` scenario that meets every expectation fails its check, and
is then promoted to `pass`. A failure of the rig (the frame, the shell, the
harness build) fails the check either way.

Each scenario writes `outcome` (its result line, then every step) to its
output. `checks.<system>.report` gathers them:

    nix build .#checks.x86_64-linux.report -L && cat result

## Layout

    flake.nix                     inputs and `inputs.blueprint { inherit inputs; }`
    lib/default.nix               flake.lib: components, vision, ethosScenario
    lib/components/ethos-zero.nix the tested generator, as its flake builds it
    lib/components/cargo.nix      the harness crate, its dependencies built once
    lib/ethos-scenario.nix        the frame: one derivation per scenario, the target
    lib/ethos-scenario.sh         the frame's helpers: generate, expect, compiles
    harness/                      Cargo.toml and lock: rkyv; datom-codec, protos under `datom`
    checks/ethos-zero-*.nix       one scenario per file
    checks/report.nix             every scenario's outcome
    fixtures/<scenario>/          the ethos files one scenario reads
    checks/lint.nix, formatter.nix  style gate

A scenario that hands Rust to rustc is named `ethos-zero-cargo-*`.
