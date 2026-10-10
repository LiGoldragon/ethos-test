# The frame's helpers. An expectation of the statement that is not met
# calls miss, which ends the drive with status 3; any other failure is the
# rig's and ends it with another status.

work=$(mktemp -d)
reply=""
rust=""
printed=""

step() {
  printf '  %s: %s\n' "$1" "$2" >>"$work/steps"
}

miss() {
  printf '%s\n' "$1" >"$work/miss"
  exit 3
}

# The fixture's absolute path, and the reply with it written as @.
fixture() {
  printf '%s/%s.ethos' "$FIXTURES" "$1"
}

answered() {
  local text=$1
  text=${text//"$FIXTURES"/@}
  text=${text//"$work"/@work}
  printf '%s' "$text"
}

# Generate fixtures/<name>/<fixture>.ethos into a fresh directory; the reply
# is in $reply, the generated file (if any) in $rust.
generate() {
  local fixture=$1
  rm -rf "$work/gen/$fixture"
  mkdir -p "$work/gen/$fixture"
  reply=$(answered "$(ethos-zero "Generate.{ $(fixture "$fixture") $work/gen/$fixture }" 2>&1 || true)")
  rust="$work/gen/$fixture/$fixture.rs"
  step "Generate $fixture" "$reply"
}

check() {
  local fixture=$1
  reply=$(answered "$(ethos-zero "Check.$(fixture "$fixture")" 2>&1 || true)")
  step "Check $fixture" "$reply"
}

expect() {
  local label=$1 got=$2 want=$3
  [ "$got" = "$want" ] || miss "$label: expected «$want», got «$got»"
}

expect_prefix() {
  local label=$1 got=$2 want=$3
  case "$got" in
  "$want"*) ;;
  *) miss "$label: expected «$want…», got «$got»" ;;
  esac
}

expect_contains() {
  local label=$1 got=$2 want=$3
  case "$got" in
  *"$want"*) ;;
  *) miss "$label: expected «$want» within «$got»" ;;
  esac
}

# The generated Rust with its whitespace runs collapsed to one space, so an
# item reads on one line however the generator wraps it.
flat() {
  [ -f "$rust" ] || miss "no generated file: $reply"
  tr -s '[:space:]' ' ' <"$rust"
}

# The generated Rust holds this item, written on one line.
expect_item() {
  local label=$1 want=$2
  case "$(flat)" in
  *"$want"*) step "$label" "holds «$want»" ;;
  *) miss "$label: the generated Rust lacks «$want»" ;;
  esac
}

expect_no_item() {
  local label=$1 unwanted=$2
  case "$(flat)" in
  *"$unwanted"*) miss "$label: the generated Rust holds «$unwanted»" ;;
  *) step "$label" "free of «$unwanted»" ;;
  esac
}

# Put the generated file and a main beside it into the harness crate.
crate() {
  local generated=$1 main=$2
  cp "$generated" src/generated.rs
  {
    printf '#[path = "generated.rs"]\nmod generated;\n#[allow(unused_imports)]\nuse generated::*;\n'
    printf '%s\n' "$main"
  } >src/main.rs
}

# rustc accepts the generated Rust with this main; features is "" or datom.
compiles() {
  local label=$1 features=$2 generated=$3 main=$4
  crate "$generated" "$main"
  if cargo build --release --offline --features "$features" >"$work/cargo" 2>&1; then
    step "$label" "compiles (features: ${features:-none})"
  else
    miss "$label: rustc refuses: $(grep -m3 -E '^error' "$work/cargo" | tr '\n' ' ')"
  fi
}

# rustc refuses this main with the given error code.
refused_by_rustc() {
  local label=$1 features=$2 generated=$3 main=$4 code=$5
  crate "$generated" "$main"
  if cargo build --release --offline --features "$features" >"$work/cargo" 2>&1; then
    miss "$label: rustc accepts it; expected $code"
  elif grep -q "error\[$code\]" "$work/cargo"; then
    step "$label" "rustc refuses with $code"
  else
    miss "$label: rustc refuses, but not with $code: $(grep -m3 -E '^error' "$work/cargo" | tr '\n' ' ')"
  fi
}

# Build and run; what the program prints is in $printed.
runs() {
  local label=$1 features=$2 generated=$3 main=$4
  crate "$generated" "$main"
  cargo build --release --offline --features "$features" >"$work/cargo" 2>&1 ||
    miss "$label: rustc refuses: $(grep -m3 -E '^error' "$work/cargo" | tr '\n' ' ')"
  printed=$(./target/release/ethos-test-harness)
  step "$label" "prints «$printed»"
}

write_outcome() {
  mkdir -p "$out"
  {
    printf '%s\n' "$1"
    cat "$work/steps" 2>/dev/null || true
  } >"$out/outcome"
}

scenario() {
  local status
  set +e
  (
    set -e
    drive
  )
  status=$?
  set -e
  local heading="$NAME («$STATEMENT»)"
  case "$status" in
  0)
    if [ "$TARGET" = pass ]; then
      write_outcome "$heading: passing"
    else
      write_outcome "$heading: unexpectedly passing (target ruled)"
      cat "$out/outcome"
      echo "ethos-test $NAME: unexpectedly passing; promote it to target pass" >&2
      exit 1
    fi
    ;;
  3)
    if [ "$TARGET" = pass ]; then
      write_outcome "$heading: failing: $(cat "$work/miss")"
      cat "$out/outcome"
      exit 1
    else
      write_outcome "$heading: expected-failing (ruled target): $(cat "$work/miss")"
    fi
    ;;
  *)
    echo "ethos-test $NAME: the rig failed with status $status" >&2
    cat "$work/steps" 2>/dev/null || true
    exit 1
    ;;
  esac
  cat "$out/outcome"
}
