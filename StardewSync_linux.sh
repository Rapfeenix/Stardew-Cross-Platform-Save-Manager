#!/bin/bash
CONFIG_FILE="$HOME/.stardew_sync_config"
ICON_PATH="$HOME/.local/share/icons/StardewSync.png"
DESKTOP_FILE="$HOME/.local/share/applications/StardewSync.desktop"

if [ ! -f "$CONFIG_FILE" ]; then
   
    PROVIDER=$(zenity --list --title="Cloud Setup" --text="Choose your cloud provider:" \
        --column="Provider" "google drive" "onedrive" "dropbox" --width=300 --height=250)

    if [ -z "$PROVIDER" ]; then exit 0; fi

   
    case "$PROVIDER" in
        "google drive") TYPE="drive"; NAME="gdrive" ;;
        "onedrive") TYPE="onedrive"; NAME="onedrive" ;;
        "dropbox") TYPE="dropbox"; NAME="dropbox" ;;
    esac

    zenity --info --text="I will now open your browser to log in to $PROVIDER.\n\nAfter you click 'Allow', come back to this app." --width=350

    
    rclone config create "$NAME" "$TYPE"

    
    echo "$NAME" > "$CONFIG_FILE"
    zenity --info --text="Setup Complete! Connected to $NAME." --timeout=2
fi


if [ ! -f "$DESKTOP_FILE" ]; then
    # 1. Download the icon silently
    mkdir -p "$(dirname "$ICON_PATH")"
    curl -sSL "https://raw.githubusercontent.com/Rapfeenix/Stardew-Cross-Platform-Save-Manager/main/StardewSync.png" -o "$ICON_PATH"

    # 2. Ask to create the shortcut
    if zenity --question --title="StardewSync Setup" --text="Installation successful!\n\nWould you like to add StardewSync to your Application Menu (Start Menu) for easy access?" --width=350; then
        echo -e "[Desktop Entry]\nType=Application\nName=StardewSync\nComment=Sync Saves & Fix UI\nExec=stardewsync\nIcon=$ICON_PATH\nTerminal=false\nCategories=Game;" > "$DESKTOP_FILE"
        chmod +x "$DESKTOP_FILE"
        
        zenity --info --text="Perfect! You can now find StardewSync in your App Menu anytime.\n\nOpening the main menu now..." --timeout=3
    fi
fi

sync_with_progress() {
    local mode=$1  # This will be "Backup" or "Restore"
    local src=$2   # Source path
    local dest=$3  # Destination path

    # -P tells rclone to output progress percentages
    # awk filters the text so it only sends numbers (0-100) to Zenity
    rclone copy "$src" "$dest" -P 2>&1 | \
    awk -vRS='\r' 'match($0, /[0-9]+%/) {print substr($0, RSTART, RLENGTH-1); fflush()}' | \
    zenity --progress \
        --title="StardewSync - $mode" \
        --text="Currently $mode-ing your farm saves..." \
        --percentage=0 \
        --auto-close \
        --width=450

    # Return the exit status of the rclone command
    return ${PIPESTATUS[0]}
}

PATH_SNAP="$HOME/snap/steam/common/.config/StardewValley/Saves"
PATH_FLATPAK="$HOME/.var/app/com.valvesoftware.Steam/.config/StardewValley/Saves"
PATH_NATIVE="$HOME/.config/StardewValley/Saves"

if [ -d "$PATH_SNAP" ]; then
    DETECTED="Snap"
    LOCAL="$PATH_SNAP"
elif [ -d "$PATH_FLATPAK" ]; then
    DETECTED="Flatpak"
    LOCAL="$PATH_FLATPAK"
elif [ -d "$PATH_NATIVE" ]; then
    DETECTED="Native"
    LOCAL="$PATH_NATIVE"
else
    DETECTED="None"
fi


USE_DETECTED=false

if [ "$DETECTED" != "None" ]; then
    if zenity --question --title="Confirm Path" --text="I found a $DETECTED version of Stardew Valley.\n\nPath: $LOCAL\n\nIs this the correct folder?" --width=400; then
        USE_DETECTED=true
    fi
fi

if [ "$USE_DETECTED" = false ]; then
    CHOICE=$(zenity --list --radiolist --title="Select Save Location" \
        --column="Pick" --column="Version" \
        TRUE "Snap" \
        FALSE "Flatpak" \
        FALSE "Native" \
        --width=300 --height=250)

    case "$CHOICE" in
        "Snap") LOCAL="$PATH_SNAP" ;;
        "Flatpak") LOCAL="$PATH_FLATPAK" ;;
        "Native") LOCAL="$PATH_NATIVE" ;;
        *) exit 0 ;; # Exit if they close the window
    esac
fi

if [ ! -d "$LOCAL" ]; then
    zenity --error --title="Error" --text="The selected folder does not exist:\n$LOCAL"
    exit 1
fi




USER_REMOTE=$(cat "$CONFIG_FILE")
REMOTE="$USER_REMOTE:Stardew Valley Save"

SCREEN_RES=$(xrandr | grep '*' | head -n1 | awk '{print $1}')
WIDTH=$(echo $SCREEN_RES | cut -d'x' -f1)
HEIGHT=$(echo $SCREEN_RES | cut -d'x' -f2)


zenity --info --text="Detected Resolution: ${WIDTH}x${HEIGHT}" --timeout=2


WIDTH=${WIDTH:-1280}
HEIGHT=${HEIGHT:-720}


apply_anjay_settings() 

{
find "$LOCAL" -type f -not -name "*SaveGameInfo*" -not -name "*.vdf" -not -name "*_old" | while read -r save_file; do
        sed -i \
            -e "s/<preferredResolutionX>[0-9.]*<\/preferredResolutionX>/<preferredResolutionX>${WIDTH}<\/preferredResolutionX>/g" \
            -e "s/<preferredResolutionY>[0-9.]*<\/preferredResolutionY>/<preferredResolutionY>${HEIGHT}<\/preferredResolutionY>/g" \
            -e 's/<uiScale>[0-9.]*<\/uiScale>/<uiScale>1<\/uiScale>/g' \
            -e 's/<zoomLevel>[0-9.]*<\/zoomLevel>/<zoomLevel>1<\/zoomLevel>/g' \
            "$save_file"
    done
}


choice=$(zenity --list --title="StardewSync CrossPlatform-Save" \
    --column="Options" \
    "Backup" \
    "Restore" \
    --width=300 --height=300)

case "$choice" in
    *"Backup"*)
        apply_anjay_settings
        
        # Calling the progress function
        if sync_with_progress "Backup" "$LOCAL" "$REMOTE"; then
            zenity --info --title="Success" \
                --text="<span font='13'>✅ <b>Settings adjusted & Backed up!</b>\n\nYour farm is now safe in the cloud.</span>" \
                --width=400
        else
            zenity --error --title="Error" --text="❌ Backup failed. Please check your internet or rclone config."
        fi
        ;;
        
    *"Restore"*)
        # Calling the progress function
        if sync_with_progress "Restore" "$REMOTE" "$LOCAL"; then
            apply_anjay_settings
            zenity --info --title="Success" \
                --text="<span font='13'>✅ <b>Retrieval & UI Adjustment Successful!</b>\n\nWelcome back to the farm!</span>" \
                --width=400
        else
            zenity --error --title="Error" --text="❌ Retrieval failed."
        fi
        ;;
        
    *)
        exit 0
        ;;
esac
