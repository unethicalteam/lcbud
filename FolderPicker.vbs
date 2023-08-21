Set objShell = CreateObject("Shell.Application")
Set objFolder = objShell.BrowseForFolder(0, "Select a folder (NO SPACES IN FOLDER NAME)", 0, 0)
Wscript.Echo """" & objFolder.Self.Path & """"
