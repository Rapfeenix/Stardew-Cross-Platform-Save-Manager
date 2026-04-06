**Have you ever spent a whole evening decorating your farms? If you had, then you know how suck much if sucks to go to work the next day, and unable to finish what you do.**
Lucky for you now you can play the same stardew valley farm on both your pc and mobile phone, so you can continue your grind anywhere with StardewSync ^_^
<br>

StardewSync let you back up and restore your save file from your pc to cloud storage with rclone. It uses zenity for simple gui, so that you can do the backup and restore with a single click.

<br>


*Also, it has the ability to change the resolution/uiscale/zoomlevel in your save file automatically.*
**Your game will scale up perfectly on both your pc and mobile without additional step!**

<br>
<br>
<br>



💡 Technical points:

*XML Auto-Patching: Utilizes sed to automatically update <uiScale> and <zoomLevel> within the save files during the Restore process. This ensures the game's UI and scaling are perfectly adjusted the moment it's launched.

*Rclone Integration: Leverages rclone to provide stable and reliable cloud synchronization with Google Drive.

*GUI & Shortcut: Features an intuitive menu built with Zenity and a dedicated .desktop entry, allowing for a seamless "point-and-click" experience directly from the Ubuntu app launcher.


<br>

🛠️ How to use:

1.Install rclone and connect your choice of cloud storage

2.Install Zenity

3.Download stardew_Cross-Platform.sh
    
4.Open stardew_Cross-Platform.sh with text editor and change this:

        LOCAL="/home/yourname/snap/steam/common/.config/StardewValley/Saves"
and this:
<br>
```
        REMOTE="budi:Stardew Valley Save" 
```
to your own need
<br>
<br>
5.Download StardewSync.desktop and move it to:

        /home/yourname/.local/share/applications/

6.open StardewSync.desktop with text editor Change this line to your stardew_Cross-Platform.sh location:

        Exec=bash "/home/yourname/Documents/VsCode/Stardew Valley Cross-Platform Save Manager/stardew_Cross-Platform.sh"

7.Open the StardewSync.desktop from your dekstop and
backup/restore your save file 

8.Enjoy doing your farm in clossplatform for linux and android :)

<br>
<br>

🚀 Next Work-flow:

*Windows support

*Automatic Backup Feature

*Standalone android application support

*IOS/MAC support