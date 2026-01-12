@echo off
@REM --- Builds the final Release executable for distribution ---

echo --- Building for Release ---

if not exist bin (
    echo Creating 'bin' directory...
    mkdir bin
)

odin build ./src -out:bin/timber.exe -vet -strict-style -vet-tabs -disallow-do -warnings-as-errors -o:aggressive

@REM --- Check if the build failed ---
if errorlevel 1 (
    echo.
    echo BUILD FAILED.
    goto :eof
)

echo.
echo Release build 'timber.exe' created successfully.
