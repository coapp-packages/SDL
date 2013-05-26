@echo off
setlocal

if "%1"=="clean" goto :clean
if "%1"=="noclean" (
	set __NOCLEAN__=true
	shift)

setlocal
call "C:\Program Files (x86)\Microsoft Visual Studio 11.0\VC\vcvarsall.bat" amd64
call :build x64 v110
endlocal

setlocal
call "C:\Program Files (x86)\Microsoft Visual Studio 11.0\VC\vcvarsall.bat" x86
call :build Win32 v110
endlocal

setlocal
call "C:\Program Files (x86)\Microsoft Visual Studio 10.0\VC\vcvarsall.bat" amd64
call :build x64 v100
endlocal

setlocal
call "C:\Program Files (x86)\Microsoft Visual Studio 10.0\VC\vcvarsall.bat" x86
call :build Win32 v100
endlocal

if "__NOCLEAN__"=="true" goto :eof

goto :clean

:build
msbuild /P:Platform=%1 /P:Configuration=Debug /P:PlatformToolset=%2 ..\VisualC10\SDL.sln
msbuild /P:Platform=%1 /P:Configuration=Release /P:PlatformToolset=%2 ..\VisualC10\SDL.sln
msbuild /P:Platform=%1 /P:Configuration=Release_NoSTDIO /P:PlatformToolset=%2 ..\VisualC10\SDL.sln
)
goto :eof

:clean
rd /s /q ..\VisualC10\SDL\v100
rd /s /q ..\VisualC10\SDL\v110
rd /s /q ..\VisualC10\SDLmain\v100
rd /s /q ..\VisualC10\SDLmain\v110

