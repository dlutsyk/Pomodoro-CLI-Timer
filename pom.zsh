#!/bin/zsh

# Use saved custom or show menu
if [[ -n "$POMO_WORK" && -n "$POMO_BREAK" ]]; then
    # Custom already set from previous cycle
    choices=("${POMO_WORK}/${POMO_BREAK}" "25/5" "50/10" "Custom" "Exit")
    split="$(gum choose "${choices[@]}" --header "Choose a pomodoro split.")"
else
    split="$(gum choose "25/5" "50/10" "Custom" "Exit" --header "Choose a pomodoro split.")"
fi

[[ -z "$split" ]] && exit 1

case "$split" in
    '25/5')
        work="25m"; break="5m" ;;
    '50/10')
        work="50m"; break="10m" ;;
    "${POMO_WORK}/${POMO_BREAK}")
        work="$POMO_WORK"; break="$POMO_BREAK" ;;
    'Custom')
        work="$(gum input --placeholder "Work duration (e.g. 30m, 45m, 1h)")"
        [[ -z "$work" ]] && exit 1
        break="$(gum input --placeholder "Break duration (e.g. 5m, 10m)")"
        [[ -z "$break" ]] && exit 1
        ;;
    'Exit'|'')
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

# Break prompt with options
while true; do
    if gum confirm "Ready for a break?"; then
        # Yes - take break
        timer "$break" && terminal-notifier -message 'Pomodoro' \
            -title 'Break is over! Get back to work 😬' \
            -sound Crystal
        break
    else
        # No - show options menu
        choice="$(gum choose "Continue working" "Take break later (5m)" "Exit" --header "What would you like to do?")"
        case "$choice" in
            "Continue working")
                break ;;  # skip break, loop will restart work session
            "Take break later (5m)")
                timer 5m && terminal-notifier -message 'Pomodoro' \
                    -title 'Break reminder!' -sound Crystal
                # Ask again after snooze
                ;;
            "Exit"|"")
                exit ;;
        esac
    fi
done

POMO_WORK="$work" POMO_BREAK="$break" exec "$0"
