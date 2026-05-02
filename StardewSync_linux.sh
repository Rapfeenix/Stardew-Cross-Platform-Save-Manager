#!/bin/bash

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

REMOTE="budi:Stardew Valley Save"

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


choice=$(zenity --list --title="Stardew Sync & Fix" --column="Action" "Backup" "Restore" --width=250 --height=220)

case "$choice" in
    "Backup")
       
        apply_anjay_settings
        
        
        if rclone copy "$LOCAL" "$REMOTE"; then
            zenity --info --title="Success" --text="✅ Adjusted to settings & Backed up to Drive!" --width=350
        else
            zenity --error --title="Error" --text="❌ Backup failed." --width=300
        fi
        ;;
        
    "Restore")
        
        if rclone copy "$REMOTE" "$LOCAL"; then
            
           
            apply_anjay_settings
            
            zenity --info --title="Success" --text="✅ Retrieval & UI Adjustment Successful!" --width=350
        else
            zenity --error --title="Error" --text="❌ Retrieval failed." --width=300
        fi
        ;;
        
    *)
        exit 0
        ;;
esac
