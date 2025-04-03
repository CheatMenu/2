#NoEnv
#SingleInstance Force
SetWinDelay, -1
SetControlDelay, -1
SetBatchLines, -1
ListLines, Off
DetectHiddenWindows, On
SetTitleMatchMode, 2
CoordMode, Mouse, Screen

global toggleE := false
global toggleWS := false
global toggleComplex := false
global toggleBob := false

global ClickX := 0
global StartTime := A_TickCount

; Создаем окно, которое всегда сверху и без заголовка
Gui, +AlwaysOnTop -Caption +ToolWindow +E0x20
Gui, Color, 0x000000 ; Чёрный фон
Gui, Font, s10 cWhite, Arial ; Белый текст
Gui, Show, NoActivate x100 y100 w400 h230, OverlayMenu

; Заголовок
Gui, Add, Text, x10 y10, Made By Mat
Gui, Add, Text, x10 y30 vRuntime, Runtime: 0s
Gui, Add, Text, x10 y50 w380 h2, ; Разделитель

; Клавиши управления
Gui, Add, Text, x10 y60, [F1] - AUTO FARM ABILITIES
Gui, Add, Text, x10 y80, [F2] - W/S AUTO CLOUD MASTERY
Gui, Add, Text, x10 y100, [F3] - AUTO FARM BRICK (MASTERY)
Gui, Add, Text, x10 y120, [F4] - AUTO FARM BOB (ARENA BUTTON)
Gui, Add, Text, x10 y140, [M] - Exit
Gui, Add, Text, x10 y160 w380 h2, ; Разделитель

; Информация
Gui, Add, Text, x10 y170 vClickCount, Click X: %ClickX%
Gui, Add, Text, x10 y190 vMode, Current Mode: None
Gui, Add, Text, x10 y210 vVersion, Skylex Version: 1.3.0

SetTimer, UpdateTime, 1000
return

UpdateTime:
    Elapsed := (A_TickCount - StartTime) // 1000
    GuiControl,, Runtime, Runtime: %Elapsed%s
return

~LButton:: 
    MouseGetPos, ClickX
    GuiControl,, ClickCount, Click X: %ClickX%
return

F1:: ; Автоферма
    toggleE := !toggleE
    GuiControl,, Mode, Current Mode: E-Spam
    if (toggleE) {
        SetTimer, PressE, 1000
    } else {
        SetTimer, PressE, Off
    }
return

PressE:
    Send, e
return

F2:: ; Авто облака
    toggleWS := !toggleWS
    GuiControl,, Mode, Current Mode: W/S Loop
    if (toggleWS) {
        SetTimer, MoveLoop, 0
    } else {
        SetTimer, MoveLoop, Off
        Send, {w up}{s up}
    }
return

MoveLoop:
    Send, {w down}
    Sleep, 5000
    Send, {w up}
    Send, {s down}
    Sleep, 5000
    Send, {s up}
return

F3:: ; Комплексная ферма
    toggleComplex := !toggleComplex
    GuiControl,, Mode, Current Mode: Complex Loop
    if (toggleComplex) {
        SetTimer, ActionLoop, 0
    } else {
        SetTimer, ActionLoop, Off
        Send, {Shift up}{E up}{D up}{W up}{S up} 
    }
return

ActionLoop:
    Send, {Shift down}
    Sleep, 50
    Sleep, 2000
    Send, e
    Sleep, 50
    Send, d
    Sleep, 50

    Loop, 5 {
        Send, e
        Sleep, 50
        Send, {d down}
        Sleep, 5
        Send, {d up}    
        Sleep, 5
        Send, {w down}
        Sleep, 20
        Send, {w down}
        Sleep, 100
        Send, {w up}
        Sleep, 100
        Send, {s down}
        Sleep, 100
        Send, {s up}
        Sleep, 100
    }

    Sleep, 50
    goto, ActionLoop
return

F4:: ; Автоферма Bob
    toggleBob := !toggleBob
    GuiControl,, Mode, Current Mode: Auto Farm BOB
    if (toggleBob) {
        SetTimer, AutoFarmBob, 500
    } else {
        SetTimer, AutoFarmBob, Off
    }
return

AutoFarmBob:
    MissingTime := 0
    Send, /    
    Send, [+] STARTED
    Send, {Enter}
    Loop {
        ImageSearch, x, y, 0, 0, A_ScreenWidth, A_ScreenHeight, *50 %A_ScriptDir%\loopdata\EnterArena.png
        if (ErrorLevel = 0) {
            Loop {
                ImageSearch, x, y, 0, 0, A_ScreenWidth, A_ScreenHeight, *50 %A_ScriptDir%\loopdata\EnterArena.png
                if (ErrorLevel = 0) {
                    MouseMove, x, y, 10
                    Sleep, 100
                    Click
                    Sleep, 500
                    Send, {e}
                    Sleep, 50
                    Send, {Escape}
                    Sleep, 200
                    Send, r
                    Sleep, 200
                    Send, {Enter}
                    MouseMove, x, y-10, 0
                } else {
                    MissingTime += 100
                    if (MissingTime >= 7000) {
                        MouseMove, x, y-10, 0
                        Send, {Escape}
                        Sleep, 200
                        Send, r
                        Sleep, 200
                        Send, {Enter}
                        MissingTime := 0
                        break
                    }
                }
                Sleep, 100
            }
        }
        Sleep, 100
    }
return

m::ExitApp  ; Выход из программы
