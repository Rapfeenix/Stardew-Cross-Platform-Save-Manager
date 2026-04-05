#!/bin/bash

#changethistoyourlocations
LOCAL="/home/phoenix/snap/steam/common/.config/StardewValley/Saves"
REMOTE="budi:Stardew Valley Save"


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
            zenity --info --title="Success" --text="✅ Adjusted to anjay settings & Backed up to Drive!" --width=350
        else
            zenity --error --title="Error" --text="❌ Backup failed." --width=300
        fi
        ;;
        
    "Restore")
        
        if rclone copy "$REMOTE" "$LOCAL"; then
            
           
            apply_anjay_settings
            
            zenity --info --title="Success" --text="✅ Retrieval & UI Adjustment (Jacob Style) Successful!" --width=350
        else
            zenity --error --title="Error" --text="❌ Retrieval failed." --width=300
        fi
        ;;
        
    *)
        exit 0
        ;;
esac
