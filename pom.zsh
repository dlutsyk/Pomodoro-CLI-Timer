#!/bin/zsh

split="${POMO_SPLIT:-$(gum choose "25/5" "50/10" "all done" --header "Choose a pomodoro split.")}"

[[ -z "$split" ]] && exit 1

case "$split" in
    '25/5')
        work="25m"; break="5m" ;;
    '50/10')
        work="50m"; break="10m" ;;
    'all done')
        exit ;;
esac

# Enable DND for work session
shortcuts run "Focus On" 2>/dev/null

# Ensure DND disabled on exit
trap 'shortcuts run "Focus Off" 2>/dev/null' EXIT

timer "$work" && terminal-notifier -message 'Pomodoro' \
    -title 'Work Timer is up! Take a Break 😊' \
    -sound Crystal

# Disable DND for break
shortcuts run "Focus Off" 2>/dev/null

gum confirm "Ready for a break?" || exit
timer "$break" && terminal-notifier -message 'Pomodoro' \
    -title 'Break is over! Get back to work 😬' \
    -sound Crystal
exec "$0"
