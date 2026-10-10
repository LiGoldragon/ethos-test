# The compiler a scenario hands generated Rust to: a crate (harness/) that
# depends on rkyv always and on datom-codec and protos under its `datom`
# feature, as a crate holding generated Rust does. Its dependencies are
# vendored and built once, then shared by every scenario.
{ inputs }:
{ pkgs, system }:
let
  rust = inputs.rust-build.lib.${system}.fromPkgs pkgs;
  inherit (rust) craneLib;
  src = ../../harness;
  cargoVendorDir = craneLib.vendorCargoDeps { cargoLock = ../../harness/Cargo.lock; };
  common = {
    inherit src cargoVendorDir;
    pname = "ethos-test-harness";
    version = "0.1.0";
    strictDeps = true;
  };
in
{
  inherit craneLib src;
  derivation =
    attributes:
    craneLib.mkCargoDerivation (
      common
      // {
        cargoArtifacts = craneLib.buildDepsOnly (common // { cargoExtraArgs = "--features datom"; });
        doInstallCargoArtifacts = false;
        doCheck = false;
      }
      // attributes
    );
}
