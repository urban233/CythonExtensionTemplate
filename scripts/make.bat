@Echo off
REM %~dp0 -> Path of script

set repoPath=%~dp0..
set pythonLibPath=%repoPath%\.venv\Lib
set interpreterFilepath=%repoPath%\.venv\Scripts\python.exe
set cythonSrcPath=%repoPath%\src\cython
set cythonCoreSrcPath=%repoPath%\src\cython\core
set cythonCoreDistPath=%repoPath%\src\cython\core\dist
set cmakeBuildDir=%cythonSrcPath%\main\cmake-build
set cBuildDir=%cythonSrcPath%\main\auto
set cDistDir=%cythonSrcPath%\main\dist
set testDir=%cythonSrcPath%\test
set testRunDir=%cythonSrcPath%\test\run
set testLibDir=%cythonSrcPath%\test\Lib

:main
    if "%1"=="rebuild-c" (goto RebuildC)
    if "%1"=="build-c" (goto BuildC)
    if "%1"=="build-pyx" (goto BuildPyx)
    if "%1"=="setup-test" (goto SetupTest)
    if "%1"=="test" (goto Test) else (goto Usage)
    goto End

:Usage
	ECHO Usage:
	ECHO rebuild-c:         Rebuilds the Visual Studio 2022 project to build the main.exe
	ECHO build-c:           Builds the Visual Studio 2022 project to create the main.exe
	ECHO build-pyx:         Builds the pyx files into a pyd
	ECHO    --clean:        Cleans the build directory of the pyx build
	ECHO setup-test:        Sets up the Lib test directory
	ECHO test:              Tests the pyx files in combination with the main.exe
	exit 0

:RebuildC
    call :cleanCmakeBuildDir
    call :buildMainExe
	goto End

:BuildC
    call :buildMainExe
    goto End

:BuildPyx
    REM Build .pyx files
    cd %cythonCoreSrcPath%
    %interpreterFilepath% setup.py
    if exist %testRunDir%\mymodule.cp311-win_amd64.pyd (del %testRunDir%\mymodule.cp311-win_amd64.pyd)
    copy %cythonCoreDistPath%\mymodule.cp311-win_amd64.pyd %testRunDir%\mymodule.cp311-win_amd64.pyd
    if "%2"=="--clean" (call :cleanCmakeBuildDir) else (goto End)

:Test
    if exist %testRunDir% (
        rmdir /s /q %testRunDir%
    )
    mkdir %testRunDir%
    xcopy %cythonCoreDistPath% %testRunDir% /e /h /c /i
    xcopy %cDistDir% %testRunDir% /e /h /c /i
    cd %testRunDir%
    echo --- Begin output of main.exe ---
    .\main.exe
    goto End

:SetupTest
    if not exist %pythonLibPath% (
        echo Please setup a .venv under the project root using the requirements_dev.txt
        goto End
    )
    if not exist %testLibDir% (
        mkdir %testLibDir%
    )
    xcopy %pythonLibPath% %testLibDir% /e /h /c /i
    goto End


REM Function definitions
REM --- Cleans the CMake build directory for VS 2022
:cleanCmakeBuildDir
    if exist %cmakeBuildDir% (
        rmdir /s /q %cmakeBuildDir%
    )
    mkdir %cmakeBuildDir%
    cd %cmakeBuildDir%
    cmake ..

REM --- Cleans the pyx build
:cleanPyxBuildDir
    rmdir /s /q %cythonCoreSrcPath%\build

REM --- Builds the main.exe file using CMake and VS 2022
:buildMainExe
    if exist %cBuildDir% (
        rmdir /s /q %cBuildDir%
    )
    mkdir %cBuildDir%
    cd %cythonSrcPath%\main
    cython .\main.pyx -3 --embed -o auto\main.c
    cd %cmakeBuildDir%
    cmake --build . --config Release
    if exist %cDistDir% (
        rmdir /s /q %cDistDir%
    )
    mkdir %cDistDir%
    copy %cmakeBuildDir%\Release\main.exe %cDistDir%\main.exe

:End
	exit 0
