#!/bin/bash

set -e



# 1. Detect package manager
if command -v apt &> /dev/null; then
    PM="apt"
elif command -v yay &> /dev/null; then
    PM="yay"
elif command -v pacman &> /dev/null; then
    PM="pacman"
else
    echo "Unsupported package manager."
    exit 1
fi

# 2. Install dependencies
if [[ $PM == "apt" ]]; then
    sudo apt update
    sudo apt install -y asusctl gamemode
elif [[ $PM == "yay" ]]; then
    yay -S --noconfirm --needed asusctl gamemode --ignore gamemode-git
elif [[ $PM == "pacman" ]]; then
    sudo pacman -S --noconfirm --needed asusctl gamemode --ignore gamemode-git
fi

# 3. Check installation
if ! command -v asusctl &>/dev/null || ! command -v gamemoded &>/dev/null; then
    echo "asusctl or gamemode not installed."
    exit 1
fi

# 4. Create systemd service
SERVICE_PATH="$HOME/.config/systemd/user/asus-performance.service"
[ -f "$SERVICE_PATH" ] && rm "$SERVICE_PATH"
mkdir -p "$(dirname "$SERVICE_PATH")"

cat > "$SERVICE_PATH" <<EOF
[Unit]
Description=ASUS Performance Mode Maintainer
After=default.target

[Service]
Type=simple
ExecStart=$HOME/.local/bin/asus_performance_loop.sh
Restart=always
RestartSec=30
StandardOutput=journal
StandardError=journal

[Install]
WantedBy=default.target
EOF

# 5. Create script that runs in loop
SCRIPT_PATH="$HOME/.local/bin/asus_performance_loop.sh"
[ -f "$SCRIPT_PATH" ] && rm "$SCRIPT_PATH"
mkdir -p "$(dirname "$SCRIPT_PATH")"

cat > "$SCRIPT_PATH" <<'EOF'
#!/bin/bash

IDLE_STATE=1

while true; do
    if gamemoded -s | grep -q "inactive"; then
        if [ "$IDLE_STATE" -eq 1 ]; then
            # Set idle state to active
            IDLE_STATE=1
            if asusctl profile -p | grep -q "Performance"; then
                asusctl profile -P Performance
                ASUSCTL_PROFILE_IDLE="Performance"
                echo "🚀 Successfully set asusctl Performance"
            fi
        fi
        IDLE_STATE=1
    elif gamemoded -s | grep -q "inactive"; then
        IDLE_STATE=0
        asusctl profile -P Performance
        echo "🚀 Successfully set asusctl Performance"
    fi

    sleep 30
done

EOF

chmod +x "$SCRIPT_PATH"

# 6. Enable and start systemd service
systemctl --user daemon-reexec
systemctl --user daemon-reload
systemctl --user enable --now asus-performance.service
systemctl --user stop --now asus-performance.service
systemctl --user start --now asus-performance.service

echo "✅ ASUS Performance systemd service has been set up."
