# PowerBackup
A lightweight, customizable, end-user friendly backup tool.

PowerBackup was designed with the intended use being to create a backup of a user's files in preparation for moving them to a new device.

Before you get started
-----------------------------------
If you are going to be backing up or restoring from a network location, you must maintain a consistent connection to that network location.

Creating a backup using PowerBackup
-----------------------------------
Move the "PowerBackup.zip" file to the users current computer, and extract

Double click on the "PowerBackup" shortcut in the newly created folder

Click "Create backup"

Ensure all items you would like to be backed up are selected

If you would like to add more items to be backed up click "Add Registry Key", "Add file", or "Add folder", and select the item you would like to add to the backup

Ensure all items you would like to be backed up are selected

Click "Start backup"

Once complete you should see a popup which says "Backup complete"


Restoring from a backup using PowerBackup
-----------------------------------
Move the "PowerBackup.zip" file to the users current computer, and extract

Double click on the "PowerBackup" shortcut in the newly created folder

Click "Restore backup"

Click "Select backup location" and select the backup folder. By default, backup folders created by PowerBackup will have the date in the name of the folder

Click "Restore from backup"

Once complete you should see a popup which says "Restore complete"


Restoring from a backup manually
-----------------------------------
Move the backup folder to the destination pc

Go into the first level of the backup (Corresponding to the drive letter, ex: "C")

Select all files and copy into the top level of the corresponding drive (Ex: contents of backup folder "C" will get moved to "C:\" on the destination computer)

Modifying the default configuration
-----------------------------------
The default parameters for PowerBackup are stored in the "bin" folder, in the file "PowerBackupConfig.cfg"

This file supports raw file paths, as well as file paths containing variables that can be resolved by Powershell (Ex: $($Env:APPDATA) will resolve to C:\Users\username\AppData\Roaming at runtime)

FAQ
-----------------------------------
What do I do if my backup/restore fails?

If your backup or restore fails you can simply start your operation again, using the same backup folder, and PowerBackup will continue where it left off.

My Documents and Desktop are empty after restoring my files

If you have your Desktop and Documents folders synced with OneDrive before backing up they will be backed up to those same locations.

To resolve this there are two options:

Enable OneDrive sync for those folders again

Manually copy the contents of the OneDrive synced folders (C:\Users\*USERNAME*\OneDrive - Enercon Services, Inc) to your new Desktop and Documents folders.
