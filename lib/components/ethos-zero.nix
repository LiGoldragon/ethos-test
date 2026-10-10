# The tested generator: ethos-zero as its own flake builds it, at the
# revision flake.lock pins.
{ inputs }:
{ system }:
{
  package = inputs.ethos-zero.packages.${system}.default;
  inherit (inputs.ethos-zero) rev;
}
