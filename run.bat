@echo off
@REM --- Runs the project in Debug Mode (fastest compile time, full debug info) ---

echo --- Running in Debug Mode ---
odin run ./src -out:timber.exe -vet -strict-style -vet-tabs -disallow-do -warnings-as-errors -debug 
