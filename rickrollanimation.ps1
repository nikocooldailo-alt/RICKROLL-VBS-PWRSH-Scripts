<#
Rickroll ASCII Animation
No downloads, no encoded payloads, no suspicious code.
#>

# Make the PowerShell window always on top and move it to the top left with a smaller size
Add-Type @"
using System;
using System.Runtime.InteropServices;
public class Win32 {
  [DllImport("user32.dll")]
  [return: MarshalAs(UnmanagedType.Bool)]
  public static extern bool SetWindowPos(IntPtr hWnd, IntPtr hWndInsertAfter, int X, int Y, int cx, int cy, uint uFlags);
  [DllImport("kernel32.dll")]
  public static extern IntPtr GetConsoleWindow();
}
"@
$hwnd = [Win32]::GetConsoleWindow()
$HWND_TOPMOST = [IntPtr]::op_Explicit(-1)
# Move to (0,0), set size to 400x200, and set always on top
[Win32]::SetWindowPos($hwnd, $HWND_TOPMOST, 0, 0, 400, 200, 0)

$frames = @(
@"
  O    
 /|\  
 / \  
"@,
@"
 \O/  
  |   
 / \  
"@,
@"
  O/  
 /|   
 / \  
"@,
@"
 \O   
  |\  
 / \  
"@
)

# Lyrics for each frame
$lyrics = @(
    "Never gonna give you up!",
    "Never gonna let you down!",
    "Never gonna run around!",
    "And desert you!"
)

# Animation parameters
$windowWidth = 40  # Number of columns in the window (approximate)
$rickWidth = 12    # Width of the widest frame (including padding)
$maxOffset = $windowWidth - $rickWidth
$topPadding = 4    # Number of blank lines above Rick
$windowHeight = 10 # Approximate number of lines in the window

# Animate Rick dancing left to right and back
for ($loop = 0; $loop -lt 6; $loop++) {
    # Move right
    for ($offset = 0; $offset -le $maxOffset; $offset += 2) {
        for ($f = 0; $f -lt $frames.Count; $f++) {
            Clear-Host
            # Top padding
            for ($i = 0; $i -lt $topPadding; $i++) { Write-Host "" }
            # Rick, moving horizontally
            $pad = ' ' * $offset
            $frames[$f].Split("`n") | ForEach-Object { Write-Host ($pad + $_) }
            # Blank lines to reach bottom
            $linesUsed = $topPadding + 3  # 3 lines for Rick
            $blankLines = $windowHeight - $linesUsed - 1
            for ($i = 0; $i -lt $blankLines; $i++) { Write-Host "" }
            # Lyrics, centered and fixed at bottom
            $lyric = $lyrics[$f]
            $lyricPad = ' ' * [Math]::Max(0, [Math]::Floor(($windowWidth - $lyric.Length) / 2))
            Write-Host ("$lyricPad$lyric")
            Start-Sleep -Milliseconds 120
        }
    }
    # Move left
    for ($offset = $maxOffset; $offset -ge 0; $offset -= 2) {
        for ($f = 0; $f -lt $frames.Count; $f++) {
            Clear-Host
            for ($i = 0; $i -lt $topPadding; $i++) { Write-Host "" }
            $pad = ' ' * $offset
            $frames[$f].Split("`n") | ForEach-Object { Write-Host ($pad + $_) }
            $linesUsed = $topPadding + 3
            $blankLines = $windowHeight - $linesUsed - 1
            for ($i = 0; $i -lt $blankLines; $i++) { Write-Host "" }
            $lyric = $lyrics[$f]
            $lyricPad = ' ' * [Math]::Max(0, [Math]::Floor(($windowWidth - $lyric.Length) / 2))
            Write-Host ("$lyricPad$lyric")
            Start-Sleep -Milliseconds 120
        }
    }
}

Write-Host "`nHappy Scripting from PowerShell... and Rick ASCII!"

Read-Host "Press Enter to exit"