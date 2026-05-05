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

### 📱 How to Setup: Backup and Restore Stardew Valley Files (Cross-platform Windows)

Follow these steps to ensure your farm stays synced between your Windows PC and your Android device using **FolderSync**.

---

### ⚙️ Configuration Steps

1.  **Download & Install:** Get [FolderSync](https://play.google.com/store/apps/details?id=dk.tacit.android.foldersync.lite) from the Google Play Store.
2.  **Account Setup:** Add the **OneDrive** account that you use on your Windows PC.
3.  **Create FolderPair:** Create a new "FolderPair" to link your local and cloud directories.
4.  **Sync Type:** Select **Two-way** to ensure progress is updated on both your phone and the cloud.
5.  **Local Folder (Left):** Select **Internal Storage** and navigate to the following path:
    > `/storage/emulated/0/Android/data/com.chucklefish.stardewvalley/files/Saves/`
6.  **Cloud Folder (Right):** Select **OneDrive** and navigate to:
    > `YourOneDrive\Stardew Save`
7.  **Save:** Tap the save icon to store your configuration.
8.  **Sync Option** For *conflict* choose *overwrite oldest* to ensure you play the latest save file
9.  **Sync** Just click sync whenever you want to play on a different device

---

<br>

## 🐧 How to Set Up StardewSync on Linux

The installation process is now automated. Follow these steps to get synced in seconds:

---

### **Step 1: Run the Automated Installer**
Open your terminal and paste this command. It installs all necessary tools (`rclone`, `zenity`, etc.) and the StardewSync script:

```bash
sudo apt update && sudo apt install curl rclone zenity x11-xserver-utils -y && sudo curl -L https://raw.githubusercontent.com/Rapfeenix/Stardew-Cross-Platform-Save-Manager/main/StardewSync_linux.sh -o /usr/local/bin/stardewsync && sudo chmod +x /usr/local/bin/stardewsync && stardewsync
```

### **Step 2: Connect Your Cloud Storage**
When prompted by the script, follow the on-screen instructions to link your cloud provider (OneDrive, Google Drive, etc.) via **rclone**.

### **Step 3: Select Your Platform**
The script will ask you to identify your installation type (e.g., Steam, Snap, or Flatpak). It will then **automatically** detect:
* Your Stardew Valley save file paths.
* Your monitor's current screen resolution.

### **Step 4: Sync Your Farm**
Choose **Backup** or **Restore** from the menu.


### **Step 5: Daily Use**
You can launch the sync manager whenever you want to play:
* **Via App Drawer:** Just click the **StardewSync** icon in your applications menu/app drawer.
* **Via Terminal:** Type `stardewsync` and hit Enter.

**Enjoy your cross-platform farm between Linux and Android! :)**

<br>

## 📱 How to Setup: Backup and Restore Stardew Valley Files (Cross-platform Linux)

Follow these steps to ensure your farm stays synced between your Linux PC and your Android device using **FolderSync**.

---

### ⚙️ Configuration Steps

1.  **Download & Install:** Get [FolderSync](https://play.google.com/store/apps/details?id=dk.tacit.android.foldersync.lite) from the Google Play Store.
2.  **Account Setup:** Add the **Cloud Account** (OneDrive, Google Drive, etc.) that you connected to **rclone** on your Linux PC.
3.  **Create FolderPair:** Create a new "FolderPair" to link your local and cloud directories.
4.  **Sync Type:** Select **Two-way** to ensure progress is updated on both your phone and the cloud.
5.  **Local Folder (Left):** Select **Internal Storage** and navigate to the following path:
    > `/storage/emulated/0/Android/data/com.chucklefish.stardewvalley/files/Saves/`
6.  **Cloud Folder (Right):** Select your **Cloud Service** and navigate to:
    > `YourRcloneCloud:Stardew Valley Save`
7.  **Save:** Tap the save icon to store your configuration.
8.  **Sync Option:** For **conflict**, choose **overwrite oldest** to ensure you always play the latest save file.
9.  **Sync:** Just click sync whenever you want to play on a different device.

---

### 💡 Pro-Tips for Farmers
* **Sync Often:** Always sync **before** you start playing and **after** you save your game on Android.
* **Consistency:** Ensure the cloud folder matches the location used by `stardewsync` on your pc.

**Enjoy your cross-platform farm between pc and Android! :)**

<br>

## 🚀 Next Work-flow:

### Automatic Backup Feature

### Standalone android application support

### IOS/MAC support
