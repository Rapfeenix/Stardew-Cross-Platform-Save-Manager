 #!/bin/bash

CONFIG_FILE="$HOME/.stardew_sync_config"

ICON_PATH="$HOME/.local/share/icons/StardewSync.png"

DESKTOP_FILE="$HOME/.local/share/applications/stardewsync.desktop"


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

    mkdir -p "$(dirname "$ICON_PATH")"

    curl -sSL "https://raw.githubusercontent.com/Rapfeenix/Stardew-Cross-Platform-Save-Manager/main/StardewSync.png" -o "$ICON_PATH"


    if zenity --question --title="stardewsync Setup" --text="Installation successful!\n\nWould you like to add stardewsync to your Application Menu (Start Menu) for easy access?" --width=350; then

        echo -e "[Desktop Entry]\nType=Application\nName=stardewsync\nComment=Sync Saves & Fix UI\nExec=stardewsync\nIcon=$ICON_PATH\nTerminal=false\nCategories=Game;" > "$DESKTOP_FILE"

        chmod +x "$DESKTOP_FILE"

        

        zenity --info --text="Perfect! You can now find stardewsync in your App Menu anytime.\n\nOpening the main menu now..." --timeout=3

    fi

fi


sync_with_progress() {

    local mode=$1  

    local src=$2  

    local dest=$3  


    

    rclone copy "$src" "$dest" -P 2>&1 | \

    awk -vRS='\r' 'match($0, /[0-9]+%/) {print substr($0, RSTART, RLENGTH-1); fflush()}' | \

    zenity --progress \

        --title="StardewSync - $mode" \

        --text="Currently $mode-ing your farm saves..." \

        --percentage=0 \

        --auto-close \

        --width=450


    

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

        *) exit 0 ;;

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

            -e 's/<zoomLevel>[0-9.]*<\/zoomLevel>/<zoomLevel>0.5<\/zoomLevel>/g' \

            "$save_file"

    done

}



auto_sync() {

    zenity --info --title="Auto-Sync" --text="Analyzing local and cloud saves using hash checksums..." --timeout=2 --width=350


    

    rclone check "$LOCAL" "$REMOTE" --one-way --combined - 2>/dev/null

    local check_status=$?


    if [ $check_status -eq 0 ]; then

        

        zenity --info --title="Up to Date" --text="✅ Both local and cloud saves are identical and fully up to date!" --width=350

        return 0

    fi


    
    local_time=$(find "$LOCAL" -type f -exec stat -c '%Y' {} + 2>/dev/null | sort -nr | head -n1)

    local_time=${local_time:-0}


   

    remote_time=$(rclone lsf "$REMOTE" -R --format "t" --files-only 2>/dev/null | sort -r | head -n1)

    remote_time=$(echo "${remote_time:-0}" | cut -d'.' -f1)


   

    echo "DEBUG: Hash Mismatch found! Local Time: $local_time | Cloud Time: $remote_time"


   

    if [ "$local_time" -gt "$remote_time" ]; then

        
        if zenity --question --title="Auto-Sync" --text="Your Local save contains newer modifications than the Cloud.\n\nWould you like to Backup to the cloud?" --width=350; then

            apply_anjay_settings

            if sync_with_progress "Backup" "$LOCAL" "$REMOTE"; then

                zenity --info --title="Success" --text="✅ Auto-Backup successful!" --width=300

            else

                zenity --error --title="Error" --text="❌ Backup failed."

            fi

        fi

    else

       

        if zenity --question --title="Auto-Sync" --text="A newer save structure or modification was found in the Cloud.\n\nWould you like to Restore it to this PC?" --width=350; then

            if sync_with_progress "Restore" "$REMOTE" "$LOCAL"; then

                apply_anjay_settings

                zenity --info --title="Success" --text="✅ Auto-Restore & UI Adjustment successful!" --width=300

            else

                zenity --error --title="Error" --text="❌ Restore failed."

            fi

        fi

    fi

}


choice=$(zenity --list --title="StardewSync CrossPlatform-Save" \

    --column="Options" \

    "Auto-Sync (Recommended)" \

    "Backup" \

    "Restore" \

    --width=350 --height=320)


case "$choice" in

    *"Auto-Sync"*)

        auto_sync

        ;;

        

    *"Backup"*)

        apply_anjay_settings

        if sync_with_progress "Backup" "$LOCAL" "$REMOTE"; then

            zenity --info --title="Success" \

                --text="<span font='13'>✅ <b>Settings adjusted & Backed up!</b>\n\nYour farm is now safe in the cloud.</span>" \

                --width=400

        else

            zenity --error --title="Error" --text="❌ Backup failed. Please check your internet or rclone config."

        fi

        ;;

        

    *"Restore"*)

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


