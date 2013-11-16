#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Recommended for catching common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

^space::
; Save the entire clipboard
ClipSaved := ClipboardAll
; ... here make temporary use of the clipboard
clipboard = ; Start off empty to allow ClipWait to detect when the text has arrived.
Send +^!t ; send custom global hk to Express Scribe
ClipWait  ; Wait for the clipboard to contain text.

audio_time := clipboard

Clipboard := ClipSaved  ; Restore the original clipboard. Note the use of Clipboard (not ClipboardAll).
ClipSaved = ; Free the memory in case the clipboard was very large.

Send (
Send %audio_time%
Send )
return