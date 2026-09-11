#!/usr/bin/env bash
# System64 / logger.sh — sourced by other scripts for error/bug logging
# source logger.sh; log_error "message"

SCRIPT_DIR_LOGGER="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOG_DIR="$SCRIPT_DIR_LOGGER/logs"
LOG_FILE="$LOG_DIR/system.log"
MAX_LOG_LINES=5000   # trim log past this length

mkdir -p "$LOG_DIR"

_log() {
    local level="$1"; shift
    local caller
    caller="$(basename "${BASH_SOURCE[1]:-unknown}")"
    printf "[%s] [%-5s] [%s] %s\n" \
        "$(date '+%Y-%m-%d %H:%M:%S')" "$level" "$caller" "$*" >> "$LOG_FILE"

    if [[ -f "$LOG_FILE" ]] && (( $(wc -l < "$LOG_FILE") > MAX_LOG_LINES )); then
        tail -n "$MAX_LOG_LINES" "$LOG_FILE" > "$LOG_FILE.tmp" && mv "$LOG_FILE.tmp" "$LOG_FILE"
    fi
}

log_info()  { _log "INFO"  "$@"; }
log_warn()  { _log "WARN"  "$@"; }
log_error() { _log "ERROR" "$@"; }
log_bug()   { _log "BUG"   "$@"; }

# run a command, log it on failure
# usage: run_logged "some command"
run_logged() {
    local cmd="$1"
    if ! eval "$cmd" 2>/tmp/system64_err.$$; then
        log_error "command failed: '$cmd' -> $(cat /tmp/system64_err.$$ 2>/dev/null)"
        rm -f /tmp/system64_err.$$
        return 1
    fi
    rm -f /tmp/system64_err.$$
}
