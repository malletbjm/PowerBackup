Set WshShell = CreateObject("WScript.Shell")
Set fso = CreateObject("Scripting.FileSystemObject")
vbpath = fso.GetParentFolderName(WScript.ScriptFullName)
suffix = "\Run.bat"
fspec = fso.BuildPath(vbpath, suffix)
WshShell.Run chr(34) & fspec & Chr(34), 0 
Set WshShell = Nothing