# AGENTS.md

Read the `compensation-nix` skill before writing anything here, and
`compensation-nix-rationale` before discussing this repository's shape.

## What this repository is

The acceptance suite of the Ethos vision against `ethos-zero`. It contains
**no component source**. ethos-zero is a pinned flake input whose `nixpkgs`
follows this flake's:

    ethos-zero = {
      url = "github:LiGoldragon/ethos-zero";
      inputs.nixpkgs.follows = "nixpkgs";
    };

## Rules

- One file holds one scenario, component, or builder.
- A scenario names the statement it tests by its heading in
  psyche-skills `vision/ethos.md`, or by its ruled item.
- A scenario declares its target: `pass`, or `ruled` for a ruled behaviour
  not yet landed (expected-failing against the pinned ethos-zero). Promote a
  `ruled` scenario to `pass` when its check fails as unexpectedly passing.
- Every assertion has an oracle outside ethos-zero: a literal reply, a
  literal Rust item, or what rustc and the built program do with the
  generated Rust.
- Every statement without a check is listed in STATEMENTS.md with its reason.
- Name every package as `pkgs.<name>`; never `with pkgs;`.
- Format with `nix fmt -- <files>` before each commit; `checks/lint.nix` is the
  style gate.
