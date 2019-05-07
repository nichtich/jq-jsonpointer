#!/bin/bash
# jq test runner

DIR=$(dirname "${BASH_SOURCE[0]}")
LIB=$DIR/..
FAIL=0

function jsonstream() {
  jq -cr 'tostream|" ."+(.[0]|map(tostring)|join("."))+"="+(.[1]|tojson)' "$@"
}

function runtest() {
  NAME="$1"
  IN="$DIR"/$NAME.in.json
  JQ="$DIR"/$NAME.jq

  if [ -e "$IN" ]; then
    jq -L"$LIB" -f "$JQ" "$IN"
  else
    jq -L"$LIB" -f "$JQ" -n
  fi
}

testcase() {
  NAME="$1"
  OUT="$DIR"/$NAME.out.json

  if [ -e "$OUT" ]; then
    jq -e -n '[inputs]|.[0]==.[1]' <(runtest "$NAME") "$OUT" >/dev/null
  else
    runtest "$NAME" 
  fi

  if [ $? -eq 0 ]; then
    echo -e "\e[32m✔ $NAME\e[0m"
  else
    echo -e "\e[31m✘ $NAME\e[0m"
    let FAIL++
    diff -U0 -d <(jsonstream "$OUT") <(runtest "$NAME" | jsonstream) \
    | grep -e '^[+-] ' | sed 's/^/  /'
  fi
}

shopt -s nullglob
for JQ in "$DIR"/*.jq; do
  testcase $(basename "$JQ" .jq)
done

if [ $FAIL -ne 0 ]; then
  echo
  echo -e "\e[31m$FAIL tests failed!\e[0m"
  exit 1
fi
