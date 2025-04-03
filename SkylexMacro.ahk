url := "https://raw.githubusercontent.com/CheatMenu/1/refs/heads/main/SkylexMacro.ahk"

; Загружаем скрипт с URL
scriptContent := DownloadScript(url)

; Выполняем код
Eval(scriptContent)

MsgBox, Скрипт загружен и выполнен!

DownloadScript(url) {
    ; Используем HttpRequest для скачивания контента
    Http := ComObjCreate("MSXML2.XMLHTTP")
    Http.Open("GET", url, false)
    Http.Send()
    
    ; Получаем ответ и возвращаем его
    return Http.responseText
}

Eval(script) {
    ; Создаем временный скрипт
    tempFile := A_Temp "\tempScript.ahk"
    FileAppend, % script, %tempFile%
    Run, %tempFile%
}
