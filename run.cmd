@echo off
setLocal EnableExtensions EnableDelayedExpansion

if "%1"=="" (
    call :help "%~nx0"
    goto:END
)

set "id=%~nx1"
set "originalDir=_original"

call :unpackAndPatch %id% || exit /b

if EXIST ".bld" (call :echoDo rd /Q /S .bld)
call :echoDo cmake.exe -B .bld -A Win32

call :echoDo cmake.exe --build .bld --target install --config Debug   || exit /b
call :echoDo cmake.exe --build .bld --target install --config Release || exit /b

call :echoDo copy /Y "%originalDir%\Debug\*"    bin\dbg
call :echoDo copy /Y "%originalDir%%\Release\*" bin\rel

:END
exit /B 0


@rem ================================================================
rem call :echoDo cmd [args]
:echoDo
    echo "%* >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
    rem next line clears ERRORLEVEL because some commands doesn't clear it or change it
    (call)
    rem "INF || properly sets the ERRORLEVEL that would otherwise be missed when RD/RMDIR or redirection fails"
    rem "WRN || sets a different ERRORLEVEL upon failed execution of an invalid command then would occur if || were not used (1 vs. 9009)."
    rem "WRN || does not detect a non-zero ERRORLEVEL returned by a batch script as an error unless the CALL command was used."
    %* || exit /b
    rem echo "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< %*"
    exit /B 0

@rem ================================================================
rem call :help
:help
    echo USAGE:
    echo.  download:
    echo.      "cef_binary_90.6.7+g19ba721+chromium-90.0.4430.212_windows32.tar.bz2"
    echo.      or
    echo.      "cef_binary_90.6.7+g19ba721+chromium-90.0.4430.212_windows32_minimal.tar.bz2"
    echo.      from "https://github.com/chromiumembedded/cef" ... "https://cef-builds.spotifycdn.com/index.html#windows32:90"
    echo.  execute:
    echo.      %~nx0 "cef_binary_90.6.7+g19ba721+chromium-90.0.4430.212_windows32"
    echo.      or
    echo.      %~nx0 "cef_binary_90.6.7+g19ba721+chromium-90.0.4430.212_windows32_minimal"
    exit /B 0

@rem ================================================================
rem call :unpackAndPatch id
:unpackAndPatch
    if NOT EXIST "%originalDir%" (
        if NOT EXIST "%~1.tar.bz2" (
            echo please download "%~1.tar.bz2" from https://github.com/chromiumembedded/cef ... https://cef-builds.spotifycdn.com/index.html#windows32:90
            echo ... and re-run the command
            exit /B 1
        )
        echo "7z x -so %~1.tar.bz2 | 7z x -si -ttar"
        7z x -so "%~1.tar.bz2" | 7z x -si -ttar
        call :echoDo move /Y "%~1" %originalDir%
        if EXIST %originalDir%\tests (call :echoDo rd /Q /S %originalDir%\tests)
        call :echoDo git apply MT2MD.diff
    )
    exit /B 0