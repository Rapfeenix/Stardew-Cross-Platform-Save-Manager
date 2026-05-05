# StardewSync: Your Farm, Anywhere.

Ever spent an entire evening perfectly placing every keg and beehive on your PC, only to realize you’re stuck staring at a spreadsheet the next day instead of finishing your masterpiece?

**StardewSync** bridges the gap between your desk and your pocket. It’s a lightweight, cross-platform save manager that ensures your grind never has to stop, making your gameplay as flexible as a Forest Farm layout.

---

### **The Magic: Intelligent Auto-Scaling**
The biggest headache with cross-platform saves is the UI. A save file optimized for a small mobile screen looks massive and awkward on a 27-inch PC monitor.

**StardewSync handles the math for you.** It automatically detects your device's display and rewrites the resolution, UI scale, and zoom level within your save file during the transfer. When you move your save from Android to PC, it’s already perfectly upscaled for your desktop—no menu-fiddling required.

---

### **How It Works**
We’ve kept the setup lean and native to your OS so you can spend more time farming and less time configuring:

* **Linux Power:** Uses `rclone` for robust cloud backups and **Zenity** for a clean, one-click GUI.
* **Windows Integration:** Leverages built-in **OneDrive** support for a seamless, "set it and forget it" experience.
* **Zero Manual Work:** The app automatically detects your save folder paths and device resolution, ensuring your data is always secure and your view is always clear.

---

### **Why Choose StardewSync?**

| Feature | Benefit |
| :--- | :--- |
| **Auto-Resolution** | Seamlessly scales mobile saves up for the big screen. |
| **One-Click Sync** | Backup or restore your farm in seconds. |
| **Cloud-Agnostic** | Works with your existing storage (OneDrive/Rclone). |
| **Smart Detection** | Automatically finds your save folders and hardware specs. |

---

**Stop leaving your farm behind. Download StardewSync and keep the harvest going, anywhere.**
<br>
<br>
<br>


## 🛠️ How to Set Up StardewSync on Windows

* **Download:** Get the `StardewSync_Windows.zip` file.
* **Extract:** Unzip the contents of the folder.
* **Run Installer:** Double-click `installer.bat`. This will automatically detect your monitor's resolution and your Stardew Valley save paths.
* **Launch:** Open the **StardewSync** shortcut created on your desktop.
* **Sync:** Pick your choice (**Backup** or **Restore**) from the menu.

---

That’s it! Your farm is now synced and perfectly scaled for whatever screen you're using. Enjoy the cross-platform grind between Windows and Android! :)

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
