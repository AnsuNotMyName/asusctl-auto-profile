#!/bin/bash

IDLE_STATE=1

while true; do
    if gamemoded -s | grep -q "inactive"; then
        if [ "$IDLE_STATE" -eq 1 ]; then
            # Set idle state to active
            IDLE_STATE=1

            if asusctl profile -p | grep -q "Performance"; then
                ASUSCTL_PROFILE_IDLE="Performance"
                echo "🚀 Successfully set asusctl Performance"
            elif asusctl profile -p | grep -q "Balanced"; then
                ASUSCTL_PROFILE_IDLE="Balanced"
                echo "❤️ Successfully set asusctl Balanced"
            else
                ASUSCTL_PROFILE_IDLE="Quiet"
                echo "💤 Successfully set asusctl Quiet"
            fi
        fi
        IDLE_STATE=1
        ASUSCTL_PROFILE="$ASUSCTL_PROFILE_IDLE"
    else
        IDLE_STATE=0
        ASUSCTL_PROFILE="Performance"
        echo "🚀 Successfully set asusctl Performance"
    fi

    asusctl profile -P "$ASUSCTL_PROFILE"

    sleep 1  
done
