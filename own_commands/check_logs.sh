#!/usr/bin/env bash
set -Eeuo pipefail
IFS=$'\n\t'

usage() {
  cat >&2 <<'USAGE'
Usage: scan_logs.sh [DIR] [-p PATTERN] [-o OUTFILE] [-i|-I]
  DIR         Startverzeichnis (Default: /var/log)
  -p PATTERN  Suchmuster (Regex; Default: error)
  -o OUTFILE  Ergebnisse zusätzlich in Datei schreiben
  -i          Case-insensitive (Default)
  -I          Case-sensitive
Beispiele:
  scan_logs.sh
  scan_logs.sh /var/log -p 'fail|panic|segfault' -o errors.log
USAGE
}

# Defaults
DIR="${1:-/var/log}"; shift || true
PATTERN="error"
OUTFILE=""
CASE_FLAG="-i"

# Parse flags
while getopts ":p:o:iIh" opt; do
  case "$opt" in
    p) PATTERN="$OPTARG" ;;
    o) OUTFILE="$OPTARG" ;;
    i) CASE_FLAG="-i" ;;
    I) CASE_FLAG="" ;;
    h) usage; exit 0 ;;
    \?) echo "Unknown option: -$OPTARG" >&2; usage; exit 2 ;;
    :) echo "Missing argument for -$OPTARG" >&2; usage; exit 2 ;;
  esac
done

# Header
echo "🔎 Suche '${PATTERN}' in *.log unter: ${DIR} (${CASE_FLAG:+case-insensitive})"
echo

# Sammel-Ausgabe (stdout) + optional Datei
tmpfile="$(mktemp)"
trap 'rm -f "$tmpfile"' EXIT

# Nur lesbare .log Dateien (Permission-Fehler stumm) und null-sicher
mapfile -d '' files < <(
  find "$DIR" -type f -name "*.log" -readable -print0 2>/dev/null
)

if (( ${#files[@]} == 0 )); then
  echo "Keine lesbaren .log-Dateien gefunden unter: $DIR"
  exit 0
fi

# Grep über Liste (null-sicher), mit Dateiname+Zeilennummer
# -a: treat binary as text (manche Logs enthalten NULLs)
# Fehler wie „Permission denied“ von grep unterdrücken
grep -RInH --line-number --with-filename --color=always -a ${CASE_FLAG:+$CASE_FLAG} \
  -e "$PATTERN" -- "${files[@]}" 2>/dev/null | tee "$tmpfile"

if [[ -s "$tmpfile" ]]; then
  # Zusammenfassung: Treffer pro Datei
  echo
  echo "— Zusammenfassung (Treffer pro Datei) —"
  awk -F: '{print $1}' "$tmpfile" | sort | uniq -c | sort -nr

  # Optional: in Datei speichern
  if [[ -n "$OUTFILE" ]]; then
    # Ohne Farben in Datei
    sed -E $'s/\x1B\\[[0-9;]*[mK]//g' "$tmpfile" > "$OUTFILE"
    echo
    echo "💾 Ergebnisse gespeichert nach: $OUTFILE"
  fi
else
  echo "✅ Keine Treffer."
fi

