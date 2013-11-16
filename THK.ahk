#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Recommended for catching common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

AUDIO_TIME_HK := "+^!t"

#1::      ; Interviewer
person_str := "Interviewer:"
at := " (" . get_audio_time() . ") "
Send ^b
Send %person_str%
Send ^b
Send %at%
return

#\::  ; Write a note
at := get_audio_time()
InputBox, audio_note, Audio Note, Type an audio note that will be inserted into a timestamp.,,,130
Send (%at%
if audio_note
{
  Send {Space}
  Send ^i
  Send %audio_note%
  Send ^i
}
Send )
return

get_audio_time()
{
  global AUDIO_TIME_HK
  ; Save the entire clipboard
  ClipSaved := ClipboardAll
  ; ... here make temporary use of the clipboard
  clipboard = ; Start off empty to allow ClipWait to detect when the text has arrived.
  Send %AUDIO_TIME_HK% ; send custom global hk to Express Scribe
  ClipWait  ; Wait for the clipboard to contain text.

  audio_time := clipboard

  Clipboard := ClipSaved  ; Restore the original clipboard. Note the use of Clipboard (not ClipboardAll).
  ClipSaved = ; Free the memory in case the clipboard was very large.
  
  return audio_time
}