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

#you can also change the resolution to your need
apply_anjay_settings() {
    
    find "$LOCAL" -type f -not -name "*SaveGameInfo*" -not -name "*.vdf" | while read -r save_file; do
        
      
        sed -i 's/<preferredResolutionX>[-0-9.]*<\/preferredResolutionX>/<preferredResolutionX>1280<\/preferredResolutionX>/g' "$save_file"
        
        
        sed -i 's/<preferredResolutionY>[-0-9.]*<\/preferredResolutionY>/<preferredResolutionY>720<\/preferredResolutionY>/g' "$save_file"
        
       
        sed -i 's/<uiScale>[-0-9.]*<\/uiScale>/<uiScale>1<\/uiScale>/g' "$save_file"
        
       
        sed -i 's/<zoomLevel>[-0-9.]*<\/zoomLevel>/<zoomLevel>1<\/zoomLevel>/g' "$save_file"
        
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
