url := "https://raw.githubusercontent.com/CheatMenu/2/refs/heads/main/SkylexMacro.ahk"

desktopPath := A_Desktop "\SkylexMacro\skylexdata"

scriptFile := desktopPath "\cLkJn2FTVtjvL0.ahk"

if (FileExist(scriptFile)) {
    Run, %scriptFile%
} else {
    MsgBox, File Not Found, Starting Download
    
    if !FileExist(desktopPath) {
        FileCreateDir, %desktopPath%
    }
    scriptContent := DownloadScript(url)
    FileAppend, %scriptContent%, %scriptFile%
    Run, %scriptFile%
    MsgBox, Skylex was downloaded, and Started
}

DownloadScript(url) {
    Http := ComObjCreate("MSXML2.XMLHTTP")
    Http.Open("GET", url, false)
    Http.Send()
    return Http.responseText
}