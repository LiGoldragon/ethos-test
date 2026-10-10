# The tested generator: ethos-zero as its own flake builds it, at the
# revision flake.lock pins for the given input.
{ source }:
{ system }:
{
  package = source.packages.${system}.default;
  inherit (source) rev;
}
