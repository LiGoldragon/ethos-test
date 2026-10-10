# With no argument, the CLI prints the ethos that describes its own anatomy:
# the print is ethos that ethos-zero accepts; it is the literal anatomy
# below, and it describes the CLI as it behaves: the requests Generate and
# Check, answered Generated and Checked, are the ones the print declares.
# Target: pass.
{
  pkgs,
  flake,
  system,
  ...
}:
flake.lib.ethosScenario { inherit pkgs flake system; } {
  name = "ethos-zero-self-description";
  statement = "Self-description";
  target = "pass";
  script = ''
    ethos-zero >"$work/self.ethos"
    step "no argument" "$(wc -l <"$work/self.ethos") lines"
    reply=$(answered "$(ethos-zero "Check.$work/self.ethos" 2>&1 || true)")
    expect "its own print, checked" "$reply" "Checked.@work/self.ethos"
    cat >"$work/anatomy" <<'ETHOS'
    Library
    [ datom_codec:[ Error ]
      ethos_zero:[ Problem Location ] ]
    [ Query.[ Generate.Generation
              Check.String ]
      Response.[ Generated.Vector<String>
                 Checked.String
                 Arguments.Integer
                 Malformed.Error
                 Unreadable.{ String String }
                 Rejected.{ String Location Generation_Error }
                 Unwritable.{ String String } ]
      Generation.{ String String }
      Generation_Error.[ Structural.protos:Error
                         Conceptual.{ Vector<Integer>
                                      ethos_zero:Problem } ] ]
    []
    []
    ETHOS
    diff "$work/anatomy" "$work/self.ethos" >"$work/diff" || miss "the print differs from the anatomy: $(head -c 400 "$work/diff" | tr '\n' ' ')"
    step "the anatomy" "as written"
    check record
    expect "Check, answered Checked" "$reply" "Checked.@/record.ethos"
    generate record
    expect "Generate, answered Generated" "$reply" "Generated.[ @work/gen/record/record.rs ]"
  '';
}
