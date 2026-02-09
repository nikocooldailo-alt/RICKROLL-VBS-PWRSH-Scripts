
' Rickroll Launcher - Opens YouTube and runs PowerShell animation
Dim shell
Set shell = CreateObject("WScript.Shell")

' Open Rickroll YouTube page
shell.Run "https://www.youtube.com/watch?v=dQw4w9WgXcQ", 1, False

' Launch PowerShell animation script (relative path)
scriptPath = WScript.ScriptFullName
folderPath = Left(scriptPath, InStrRev(scriptPath, "\"))
powershellFile = folderPath & "rickrollanimation.ps1"
shell.Run "powershell -NoProfile -ExecutionPolicy Bypass -WindowStyle Normal -File """ & powershellFile & """", 1, False

Set shell = Nothing
