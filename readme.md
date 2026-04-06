# StardewSync : Stardew Valley Cross-Platform Save Manager

**Have you ever spent a whole evening decorating your farms on your pc? If you have, then you know how much it sucks to go to work the next day, and unable to finish what you do.**
Lucky for you, now, you can play the same stardew valley farm, on both your pc and mobile phone. You can literally continue your grind anywhere on any device with StardewSync ^_^
<br>

StardewSync let you back up and restore your save file from your pc to cloud storage with rclone. It uses zenity for simple gui, so that you can do the backup and restore with a single click.

<br>


*Also, it has the ability to change the resolution/uiscale/zoomlevel in your save file automatically.*
**Your game will scale up perfectly on both your pc and mobile without additional step!**

<br>
<br>
<br>


## 💡 Technical points:

### XML Auto-Patching
<br>
 Utilizes sed to automatically update <uiScale> and <zoomLevel> within the save files during the Restore process. This ensures the game's UI and scaling are perfectly adjusted the moment it's launched.

### Rclone Integration
<br>
 Leverages rclone to provide stable and reliable cloud synchronization with Google Drive.

### GUI & Shortcut: 
<br>
Features an intuitive menu built with Zenity and a dedicated .desktop entry, allowing for a seamless "point-and-click" experience directly from the Ubuntu app launcher.


<br>

## 🛠️ How to use StardewSync on Linux:

1.Install rclone and connect your choice of cloud storage (gdrive/onedrive/etc)

2.Install zenity

3.Download StardewSync_linux.sh
    
4.Open the StardewSync_linux.sh with text editor and change this:

        LOCAL="/home/yourname/snap/steam/common/.config/StardewValley/Saves"
and this:
<br>
```
        REMOTE="YourCloudStorage(onedrive/gdrive/etc):YourLocation" 
```
to your own need
<br>
<br>
5.Download StardewSync_Linux.desktop and move it to:

        /home/yourname/.local/share/applications/

6.open StardewSync.desktop with text editor Change this line to your stardew_Cross-Platform.sh location:

        Exec=bash "/home/yourname/Documents/VsCode/Stardew Valley Cross-Platform Save Manager/stardew_Cross-Platform.sh"

7.Open the StardewSync.desktop from your dekstop and
backup/restore your save file 

8.Enjoy doing your farm in clossplatform for linux and android :)

<br>
<br>

## How to backup and restore Stardew valley files on your phone 📱

1. Download and install FolderSync from playstore 
2. Add a cloud storage account (gdrive/onedrive/etc) thay you used on rclone
3. Create FolderPair
4. Choose two way
5. Get internal storage for the left folder and pick this location:

        /storage/emulated/0/Android/data/com/chucklefish.stardewvalley/files/Saves/

6. Get cloud service for your right folder and pick this location:

        YourCloudStorage(onedrive/gdrive/etc):YourLocation
<br>
(the same one that you connect on rclone, linuc)

7. Save

8. Sync when you need it ^_^


## 🚀 Next Work-flow:

### Windows support

### Automatic Backup Feature

### Standalone android application support

### IOS/MAC support