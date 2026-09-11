#!/usr/bin/env bash

for i in {1..5}; do
    weather=$(curl -fsSL --max-time 10 "https://wttr.in/$1?format=%c+%t")

    if [[ $? -eq 0 && -n "$weather" ]]; then
        icon=$(echo "$weather" | awk '{print $1}')
        temp=$(echo "$weather" | awk '{print $2}')

        tooltip=$(curl -fsSL --max-time 10 "https://wttr.in/$1?format=4")
        tooltip=$(echo "$tooltip" | sed -E 's/[[:space:]]+/ /g')

temp="${temp//°C}"
printf '{"text":"%s\\n%s","tooltip":"%s"}\n' "$icon" "$temp" "$tooltip"
        exit 0
    fi

    sleep 2
done

echo '{"text":"󰖐","tooltip":"Weather unavailable"}'
