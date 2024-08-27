Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
Add-Type -AssemblyName PresentationCore,PresentationFramework
Add-Type -AssemblyName Microsoft.VisualBasic
function MainMenu {
    $form = New-Object System.Windows.Forms.Form
    $form.ShowIcon = $False
    $form.MinimizeBox = $False
    $form.MaximizeBox = $False
    $form.FormBorderStyle = 'FixedSingle'
    $form.Text = 'PowerBackup'
    $form.Size = New-Object System.Drawing.Size(200,225)
    $form.StartPosition = 'CenterScreen'

    $createBackupButton = New-Object System.Windows.Forms.Button
    $createBackupButton.Location = New-Object System.Drawing.Point(25,25)
    $createBackupButton.Size = New-Object System.Drawing.Size(125,50)
    $createBackupButton.Text = 'Create backup'
    $createBackupButton.Add_Click({
        $form.Hide()
        CreateBackupMenu
    })
    $form.Controls.Add($createBackupButton)

    $restoreBackupButton = New-Object System.Windows.Forms.Button
    $restoreBackupButton.Location = New-Object System.Drawing.Point(25,100)
    $restoreBackupButton.Size = New-Object System.Drawing.Size(125,50)
    $restoreBackupButton.Text = 'Restore backup'
    $restoreBackupButton.Add_Click({
        $form.Hide()
        CreateRestoreMenu
    })
    $form.Controls.Add($restoreBackupButton)

    $form.Topmost = $False
    $form.ShowDialog()
}

function CreateBackupMenu {
    $form = New-Object System.Windows.Forms.Form
    $form.ShowIcon = $False
    $form.MinimizeBox = $False
    $form.MaximizeBox = $False
    $form.FormBorderStyle = 'FixedSingle'
    $form.Text = 'PowerBackup'
    $form.Size = New-Object System.Drawing.Size(500,575)
    $form.StartPosition = 'CenterScreen'

    $LocationsLabel = New-Object System.Windows.Forms.Label
    $LocationsLabel.Location = New-Object System.Drawing.Point(5,5)
    $LocationsLabel.Size = New-Object System.Drawing.Size(300,15)
    $LocationsLabel.Text = 'Folders and files to backup:'
    $form.Controls.Add($LocationsLabel)

    $LocationsListbox = New-Object System.Windows.Forms.CheckedListBox
    $LocationsListbox.Location = New-Object System.Drawing.Point(5,25)
    $LocationsListbox.Size = New-Object System.Drawing.Size(470,250)
    $LocationsListbox.CheckOnClick = $True
    $form.Controls.Add($LocationsListbox)

    $registryKeyLabel = New-Object System.Windows.Forms.Label
    $registryKeyLabel.Location = New-Object System.Drawing.Point(5,275)
    $registryKeyLabel.Size = New-Object System.Drawing.Size(300,15)
    $registryKeyLabel.Text = 'Registry keys to backup:'
    $form.Controls.Add($registryKeyLabel)

    $registryKeysListbox = New-Object System.Windows.Forms.CheckedListBox
    $registryKeysListbox.Location = New-Object System.Drawing.Point(5,290)
    $registryKeysListbox.Size = New-Object System.Drawing.Size(470,100)
    $registryKeysListbox.CheckOnClick = $True
    $form.Controls.Add($registryKeysListbox)

    $AddRegistryKeyButton = New-Object System.Windows.Forms.Button
    $AddRegistryKeyButton.Location = New-Object System.Drawing.Point(155,390)
    $AddRegistryKeyButton.Size = New-Object System.Drawing.Size(100,25)
    $AddRegistryKeyButton.Text = 'Add Registry Key'
    $AddRegistryKeyButton.Add_Click({

        $form2 = New-Object System.Windows.Forms.Form
        $form2.ShowIcon = $False
        $form2.MinimizeBox = $False
        $form2.MaximizeBox = $False
        $form2.FormBorderStyle = 'FixedSingle'
        $form2.Text = 'Add Registry Key'
        $form2.Size = New-Object System.Drawing.Size(300, 115)
        $form2.StartPosition = 'CenterScreen'

        $okButton = New-Object System.Windows.Forms.Button
        $okButton.Location = New-Object System.Drawing.Point(70, 50)
        $okButton.Size = New-Object System.Drawing.Size(75, 23)
        $okButton.Text = 'OK'
        $okButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
        $form2.AcceptButton = $okButton
        $form2.Controls.Add($okButton)

        $cancelButton = New-Object System.Windows.Forms.Button
        $cancelButton.Location = New-Object System.Drawing.Point(155, 50)
        $cancelButton.Size = New-Object System.Drawing.Size(75, 23)
        $cancelButton.Text = 'Cancel'
        $cancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
        $form2.CancelButton = $cancelButton
        $form2.Controls.Add($cancelButton)

        $label = New-Object System.Windows.Forms.Label
        $label.Location = New-Object System.Drawing.Point(10, 5)
        $label.Size = New-Object System.Drawing.Size(280, 20)
        $label.Text = 'Please enter a registry key path:'
        $form2.Controls.Add($label)

        $textBox = New-Object System.Windows.Forms.TextBox
        $textBox.Location = New-Object System.Drawing.Point(10, 25)
        $textBox.Size = New-Object System.Drawing.Size(260, 20)
        $form2.Controls.Add($textBox)

        $form2.Topmost = $true

        $form2.Add_Shown({$textBox.Select()})
        $result = $form2.ShowDialog()

        if ($result -eq [System.Windows.Forms.DialogResult]::OK)
        {
            $RegistryKey = $textBox.Text
            $registryKeysListbox.Items.Add($RegistryKey, $True)
        }
    })
    $form.Controls.Add($AddRegistryKeyButton)

    $AddFileButton = New-Object System.Windows.Forms.Button
    $AddFileButton.Location = New-Object System.Drawing.Point(375,390)
    $AddFileButton.Size = New-Object System.Drawing.Size(100,25)
    $AddFileButton.Text = 'Add file'
    $AddFileButton.Add_Click({
        $File = GetFile
        if ($File -ne '') {
            $LocationsListbox.Items.Add($File, $True)
        }
    })
    $form.Controls.Add($AddFileButton)

    $AddFolderButton = New-Object System.Windows.Forms.Button
    $AddFolderButton.Location = New-Object System.Drawing.Point(265,390)
    $AddFolderButton.Size = New-Object System.Drawing.Size(100,25)
    $AddFolderButton.Text = 'Add folder'
    $AddFolderButton.Add_Click({
        $Folder = GetFolder
        if ($Folder -ne '') {
            $LocationsListbox.Items.Add($Folder, $True)
        }
        
    })
    $form.Controls.Add($AddFolderButton)

    $DestinationLabel = New-Object System.Windows.Forms.Label
    $DestinationLabel.Location = New-Object System.Drawing.Point(5,410)
    $DestinationLabel.Size = New-Object System.Drawing.Size(125,15)
    $DestinationLabel.Text = 'Backup destination:'
    $form.Controls.Add($DestinationLabel)

    $DestinationTextbox = New-Object System.Windows.Forms.TextBox
    $DestinationTextbox.Location = New-Object System.Drawing.Point(5,425)
    $DestinationTextbox.Size = New-Object System.Drawing.Size(360,15)
    $form.Controls.Add($DestinationTextbox)

    $ChooseDestinationButton = New-Object System.Windows.Forms.Button
    $ChooseDestinationButton.Location = New-Object System.Drawing.Point(375,420)
    $ChooseDestinationButton.Size = New-Object System.Drawing.Size(100,25)
    $ChooseDestinationButton.Text = 'Pick Destination'
    $ChooseDestinationButton.Add_Click({
        $DestinationTextbox.Text = GetFolder
    })
    $form.Controls.Add($ChooseDestinationButton)

    $StartBackupButton = New-Object System.Windows.Forms.Button
    $StartBackupButton.Location = New-Object System.Drawing.Point(375,450)
    $StartBackupButton.Size = New-Object System.Drawing.Size(100,50)
    $StartBackupButton.Text = 'Start backup'
    $StartBackupButton.Add_Click({
        $StartBackupButton.Enabled = $False
        $ChooseDestinationButton.Enabled = $False
        $AddFileButton.Enabled = $False
        $AddFolderButton.Enabled = $False
        $AddRegistryKeyButton.Enabled = $False
        
        #Backup files specified
        try {
            Backup $LocationsListbox.CheckedItems $registryKeysListbox.CheckedItems ([ref]$ProgressBar) $DestinationTextbox.Text

            [Microsoft.VisualBasic.Interaction]::MsgBox('Backup complete','OKOnly', 'PowerBackup')
        }
        catch {
            [Microsoft.VisualBasic.Interaction]::MsgBox("Backup failed: $($_.Exception.Message)",'OKOnly', 'PowerBackup')
        }

        $ProgressBar.Value = 1
        $StartBackupButton.Enabled = $True
        $ChooseDestinationButton.Enabled = $True
        $AddFileButton.Enabled = $True
        $AddFolderButton.Enabled = $True
        $AddRegistryKeyButton.Enabled = $True
    })
    $form.Controls.Add($StartBackupButton)

    $ProgressBar = New-Object System.Windows.Forms.ProgressBar
    $ProgressBar.Location = New-Object System.Drawing.Point(5,510)
    $ProgressBar.Size = New-Object System.Drawing.Size(475,20)
    $ProgressBar.Minimum = 1
    $ProgressBar.Value = 1
    $ProgressBar.Step = 1
    $ProgressBar.Visible = $True
    $form.Controls.Add($ProgressBar)

    #Read config file for default parameters
    $ConfigFile = ReadConfigFile
    $BackupLocations = $ConfigFile[0]
    $BackupDestination = $ConfigFile[1]
    $RegistryKeys = $ConfigFile[2]

    foreach ($line in $BackupLocations){
        $LocationsListbox.Items.Add($line, $True)
    }

    foreach ($line in $RegistryKeys) {
        $registryKeysListbox.Items.Add($line, $True)
    }

    $DestinationTextbox.Text = $BackupDestination

    $form.Topmost = $False
    $form.ShowDialog()
}

function CreateRestoreMenu() {
    $form = New-Object System.Windows.Forms.Form
    $form.ShowIcon = $False
    $form.MinimizeBox = $False
    $form.MaximizeBox = $False
    $form.FormBorderStyle = 'FixedSingle'
    $form.Text = 'PowerBackup'
    $form.Size = New-Object System.Drawing.Size(500,150)
    $form.StartPosition = 'CenterScreen'

    $LocationLabel = New-Object System.Windows.Forms.Label
    $LocationLabel.Location = New-Object System.Drawing.Point(5,5)
    $LocationLabel.Size = New-Object System.Drawing.Size(125,15)
    $LocationLabel.Text = 'Backup to restore from:'
    $form.Controls.Add($LocationLabel)

    $LocationTextbox = New-Object System.Windows.Forms.TextBox
    $LocationTextbox.Location = New-Object System.Drawing.Point(5,25)
    $LocationTextbox.Size = New-Object System.Drawing.Size(470,15)
    $form.Controls.Add($LocationTextbox)

    $ChooseLocationButton = New-Object System.Windows.Forms.Button
    $ChooseLocationButton.Location = New-Object System.Drawing.Point(5,55)
    $ChooseLocationButton.Size = New-Object System.Drawing.Size(125,25)
    $ChooseLocationButton.Text = 'Select backup folder'
    $ChooseLocationButton.Add_Click({
        #Allow user to select backup folder, if valid then enable restore button
        $LocationTextbox.Text = GetFolder
        if (($null -ne $LocationTextbox.Text) -and ($LocationTextbox.Text -ne "")) {
            $StartRestoreButton.Enabled = $True
        }
    })
    $form.Controls.Add($ChooseLocationButton)

    $StartRestoreButton = New-Object System.Windows.Forms.Button
    $StartRestoreButton.Location = New-Object System.Drawing.Point(350,55)
    $StartRestoreButton.Size = New-Object System.Drawing.Size(125,25)
    $StartRestoreButton.Text = 'Restore from backup'
    $StartRestoreButton.Enabled = $False
    $StartRestoreButton.Add_Click({
        $StartRestoreButton.Enabled = $False
        $ChooseLocationButton.Enabled = $False
        #Restore files from backup
        try {
            Restore $LocationTextbox.Text
            #[System.Windows.MessageBox]::Show('Restore complete')
            [Microsoft.VisualBasic.Interaction]::MsgBox('Restore complete','OKOnly', 'PowerBackup')
        }
        catch {
            #[System.Windows.MessageBox]::Show('Restore complete')
            [Microsoft.VisualBasic.Interaction]::MsgBox("Restore failed: $($_.Exception.Message)",'OKOnly', 'PowerBackup')
        }

        $ProgressBar.Value = 1
        $StartRestoreButton.Enabled = $True
        $ChooseLocationButton.Enabled = $True
    })
    $form.Controls.Add($StartRestoreButton)

    $ProgressBar = New-Object System.Windows.Forms.ProgressBar
    $ProgressBar.Location = New-Object System.Drawing.Point(5,85)
    $ProgressBar.Size = New-Object System.Drawing.Size(475,20)
    $ProgressBar.Minimum = 1
    $ProgressBar.Value = 1
    $ProgressBar.Step = 1
    $ProgressBar.Visible = $True
    $form.Controls.Add($ProgressBar)

    $form.Topmost = $False
    $form.ShowDialog()
}

#Resolves powershell shorthand from config file into true filepaths
function ResolveString($String) {
    return $ExecutionContext.InvokeCommand.ExpandString($String)
}

#Folder browser dialog
function GetFolder() {
    $Folder = ''
    $FolderBrowser = New-Object System.Windows.Forms.FolderBrowserDialog
    $FolderBrowser.Description = "Select backup folder"
    $FolderBrowser.RootFolder = "MyComputer"
    $FolderBrowser.SelectedPath = ''

    if($FolderBrowser.ShowDialog() -eq "OK") {
        $Folder = $FolderBrowser.SelectedPath
    }
    
    return $Folder
}

#File browser dialog
function GetFile() {
    $File = ''
    $FileBrowser = New-Object System.Windows.Forms.OpenFileDialog

    if($FileBrowser.ShowDialog() -eq "OK") {
        $File = $FileBrowser.FileName
    }
    
    return $File
}

#Parse config file to load program defaults
function ReadConfigFile() {
    $mode = ""
    $BackupLocations = @()
    $BackupDestination = ""
    $BackupRegistryKeys = @()
    try {
        foreach($line in Get-Content $PSScriptRoot\PowerBackupConfig.cfg) {
            if (($line -ne "") -AND ($line.SubString(0,1) -ne "#")) {
                switch($line) {
                    "Backup Locations:" {$mode = "backuplocations"}
                    "Backup Destination:" {$mode = "backupdestination"}
                    "Registry Keys:" {$mode = "registrykeys"}
                    Default {
                        switch($mode) {
                            "backuplocations" {
                                $BackupLocations += ResolveString($line)
                            }
                            "backupdestination" {
                                $BackupDestination = "$(ResolveString($line))\Backup-$(Get-Date -Format "MM-dd-yyyy")"
                            }
                            "registrykeys" {
                                $BackupRegistryKeys += ResolveString($line)
                            }
                        }
                    }
                }
            }
        }
    }
    catch {
        Write-Output "could not read config file"
    }

    Return @($BackupLocations, $BackupDestination, $BackupRegistryKeys)
}

#Backup items selected in backup menu
function Backup($BackupItems, $registryKeys, [ref]$ProgressBar, $BackupDestination) {

    $BackupItemsProgress = @()

    foreach ($item in $BackupItems) {
        $BackupItemsProgress += [PSCustomObject]@{
            Item = $item
            Completed = $false
        }
    }

    foreach ($item in $registryKeys) {
        $BackupItemsProgress += [PSCustomObject]@{
            Item = $item
            Completed = $false
        }
    }

    $ProgressBar.Value.Minimum = 1
    $ProgressBar.Value.Maximum = ($BackupItems.Count + $registryKeys.Count)
    $ProgressBar.Value.Value = 1
    $ProgressBar.Value.Step = 1

    $previousBackupProgress = $null

    #Check to see if backup already exists, continue from previous backup if possible
    if (Test-Path $BackupDestination) {
        try {
            $previousBackupProgress = Get-Content -Path "$BackupDestination\BackupProgress.prg" | ConvertFrom-Json

            foreach ($item in $previousBackupProgress) {
                if ($item.Completed -eq $true) {
                    $currentItem = $BackupItemsProgress | Where-Object {$_.Item -EQ $item.Item}
                    $currentItem.Completed = $true
                }
            }
        }
        catch {
        }
    }

    #If no progress file exists for previous backup, erase and start again
    if ($null -eq $previousBackupProgress) {
        New-Item "$PSScriptRoot\Empty" -ItemType Directory
        Robocopy "$PSScriptRoot\Empty" $BackupDestination /mir
        Remove-Item "$PSScriptRoot\Empty"
        Remove-Item $BackupDestination -Recurse

        #Create new backup folder
        New-Item $BackupDestination -ItemType Directory
        #If registry keys are present, create a backup folder for them
        if ($registryKeys.Count -gt 0) {
            New-Item "$($BackupDestination)\Registry Keys" -ItemType Directory
        }
    }
    
    foreach ($Item in $BackupItems) {
        #If item was not already backed up in previous backup
        if (($BackupItemsProgress | Where-Object {$_.Item -EQ $Item}).Completed -eq $false) {
            $ItemDirectory = Split-Path -Parent $Item
            $Directory = "$($BackupDestination)\$($ItemDirectory)" -replace '(\*|\||"|:|\?|<|>)', ''
            
            #If the item to be copied is a file
            if (Test-Path -Path $Item -PathType Leaf) {
                if (-not (Test-Path "$Directory")) {
                    New-Item $Directory -ItemType Directory -Force 
                }

                Copy-Item $Item -Destination $Directory
            }
            #If the item to be copied is a directory
            else {
                $RobocopyDirectory = "$Directory\$(Split-Path $Item -Leaf)"
                Robocopy $Item $RobocopyDirectory /COPY:DT /e /z /r:5 /w:15 /mt:16 /V /xj /j
            }

            $ProgressBar.Value.PerformStep()

            $currentItem = $BackupItemsProgress | Where-Object {$_.Item -EQ $Item}
            $currentItem.Completed = $true

            ConvertTo-Json -InputObject $BackupItemsProgress | Set-Content -Path "$BackupDestination\BackupProgress.prg"
        }
    }

    foreach ($item in $registryKeys) {
        reg export $item "$($BackupDestination)\Registry Keys\$($item.Replace("\", "_")).reg"

        $currentItem = $BackupItemsProgress | Where-Object {$_.Item -EQ $Item}
        $currentItem.Completed = $true

        ConvertTo-Json -InputObject $BackupItemsProgress | Set-Content -Path "$BackupDestination\BackupProgress.prg"
    }
}

function Restore($BackupLocation) {
    if (($null -ne $BackupLocation) -and ($BackupLocation -ne "")) {

        $BackupRoot = Get-ChildItem $BackupLocation

        $restoreItemsProgress = @()

        foreach ($item in $BackupRoot) {
            if (($item.Name -ne "RestoreProgress.prg") -and ($item.Name -ne "BackupProgress.prg")) {
                if ($item.Name -ne "Registry Keys") {
                    #Add all bottom level folders to restore progress list
                    foreach ($subFolder in ($item | Get-ChildItem -Recurse -Directory)) {
                        if ($null -eq ($subFolder.EnumerateDirectories()).count) {
                            $restoreItemsProgress += [PSCustomObject]@{
                                Item = $subFolder.FullName
                                Completed = $false
                            }
                        }
                        #Add any files which are not in a bottom level folder to our restore progress list
                        else {
                            foreach ($childItem in ($subFolder | Get-ChildItem)) {
                                if ($childItem.Attributes -ne "Directory") {
                                    $restoreItemsProgress += [PSCustomObject]@{
                                        Item = $childItem.FullName
                                        Completed = $false
                                    }
                                }
                            }
                        }
                    }
                    
                }
                else {
                    $restoreItemsProgress += [PSCustomObject]@{
                        Item = $item.Name
                        Completed = $false
                    }
                }
            }
        }

        try {
            $previousRestoreProgress = Get-Content -Path "$BackupLocation\RestoreProgress.prg" | ConvertFrom-Json

            foreach ($item in $previousRestoreProgress) {
                if ($item.Completed -eq $true) {
                    $currentItem = $restoreItemsProgress | Where-Object {$_.Item -EQ $item.Item}
                    $currentItem.Completed = $true
                }
            }
        }
        catch {
        }

        foreach ($item in $restoreItemsProgress) {
            if (($item.Item -ne "BackupProgress.prg") -and ($item.Item -ne "RestoreProgress.prg")) {
                if ($item.Completed -eq $false){
                    if ($item.Item -ne "Registry Keys") {
                        $DriveLetter = ($item.Item.Replace("$($BackupLocation)\", ""))[0] + ":\"
                        $ItemFullPath = $DriveLetter + ($item.Item.Replace("$($BackupLocation)\", "")).Substring(2)
                        $ItemPath = Split-Path -Path $ItemFullPath -Parent
                        $ItemName = Split-Path -Path $ItemFullPath -Leaf
                        try {
                            #If item to be restored is a file
                            if (Test-Path -Path $Item.item -PathType Leaf) {
                                Robocopy (Split-Path -Path $item.Item -Parent) $ItemPath $ItemName /COPY:DT /z /r:5 /w:15 /mt:16 /V /xj /j /nodcopy
                            }
                            #If item to be restored is a folder
                            else {
                                Robocopy $item.Item "$($ItemPath)\$($ItemName)" /COPY:DT /z /r:5 /w:15 /mt:16 /V /xj /j /nodcopy
                            }
                            
                            $item.Completed = $true
                            ConvertTo-Json -InputObject $restoreItemsProgress | Set-Content -Path "$BackupLocation\RestoreProgress.prg"
                        }
                        catch {
                            throw "Error restoring $($item.Item)"
                        }
                    }
        
                    if ($item.Item -eq "Registry Keys") {
                        foreach ($registryKey in (Get-ChildItem $item.Item)) {
                            try {
                                reg import "$($item.Item)\$($registryKey)"
                                $item.Completed = $true
                                ConvertTo-Json -InputObject $restoreItemsProgress | Set-Content -Path "$BackupLocation\RestoreProgress.prg"
                            }
                            catch {
                                throw "Error importing $($registryKey)"
                            }
                        }
                    }
                }
            }
        }
    }
    else {
        throw "Invalid backup location"
    }
}

MainMenu
