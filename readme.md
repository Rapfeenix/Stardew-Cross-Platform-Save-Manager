# StardewSync : Stardew Valley Cross-Platform Save Manager

**Have you ever spent a whole evening decorating your farms on your pc? If you have, then you know how much it sucks to go to work the next day, and unable to finish what you do.**
Lucky for you, now, you can play the same stardew valley farm, on both your pc and mobile phone. You can literally continue your grind anywhere on any device with StardewSync ^_^
<br>

On linux, StardewSync let you back up and restore your save file from your pc to cloud storage with rclone. It uses zenity for simple gui, so that you can do the backup and restore with a single click. On the other hand, windows version utilize built-in onedrive, also with similar simplicity

<br>


*Also, it has the ability to change the resolution/uiscale/zoomlevel in your save file automatically.*
**Your game will scale up perfectly on both your pc and mobile without additional step!**

<br>
<br>
<br>




## 🛠️ How to set up StardewSync on Windows:

1.Download StardewSync.txt

2.Open it with text editor

3.Change this:


        set "REMOTE_SAVE=%OneDrive%\yourlocation"
<br>

to stardew valley save folder location that you want on onedrive

<br>
<br>
4. Find this in the txt

        <preferredResolutionX>1280</preferredResolutionX>

and this:

```
<preferredResolutionY>720</preferredResolutionY>
```
and change them to your monitor resolution


5.Rename the extention of file from StardewSync.txt to StardewSync.bat

<br>

6.Run StardewSync.bat

<br>

7.Pick the choice that you want (backup/restore) 

<br>

8.Enjoy doing your farm in clossplatform for windows and android :)

<br>
<br>

## How to setup: backup and restore Stardew valley files on your phone (crossplatform windows) 📱

1. Download and install FolderSync from playstore 
2. Add onedrive account that you used on your windows
3. Create FolderPair
4. Choose two way
5. Get internal storage for the left folder and pick this location:

        /storage/emulated/0/Android/data/com/chucklefish.stardewvalley/files/Saves/

6. Get cloud service for your right folder and pick this location:

        Onedrive:YourLocation
<br>
(the same location that you put on StardewSync.bat)

7. Save

8. Sync before and after you play on android ^_^

<br>

## 🛠️ How to set up StardewSync on Linux:

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
5.Change the resolution in this:
```
sed -i 's/<preferredResolutionX>[-0-9.]*<\/preferredResolutionX>/<preferredResolutionX>1280<\/preferredResolutionX>/g' "$save_file"
```
and this:
```
        
        
sed -i 's/<preferredResolutionY>[-0-9.]*<\/preferredResolutionY>/<preferredResolutionY>720<\/preferredResolutionY>/g' "$save_file"
```

to your own screen resolution

6.Download StardewSync_Linux.desktop and move it to:

        /home/yourname/.local/share/applications/

7.open StardewSync.desktop with text editor Change this line to your stardew_Cross-Platform.sh location:

        Exec=bash "/home/yourname/Documents/VsCode/Stardew Valley Cross-Platform Save Manager/stardew_Cross-Platform.sh"

8.Open the StardewSync.desktop from your dekstop and
backup/restore your save file 

9.Enjoy doing your farm in clossplatform for linux and android :)

<br>

## How to set up: backup and restore Stardew valley files on your phone (Crossplatform linux) 📱

1. Download and install FolderSync from playstore 
2. Add a cloud storage account (gdrive/onedrive/etc) that you used on rclone
3. Create FolderPair
4. Choose two way
5. Get internal storage for the left folder and pick this location:

        /storage/emulated/0/Android/data/com/chucklefish.stardewvalley/files/Saves/

6. Get cloud service for your right folder and pick this location:

        YourCloudStorage(onedrive/gdrive/etc):YourLocation

<br>

(the same one that you connect on rclone, linux)

7. Save

8. Sync before and after you play on android ^_^

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

## 🚀 Next Work-flow:

### Automatic Backup Feature

### Standalone android application support

### IOS/MAC support