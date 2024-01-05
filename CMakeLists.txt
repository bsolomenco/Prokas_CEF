#rd /Q /S .bld & cmake -B .bld -A Win32 && cmake --build .bld --target install --config Release
#rd /Q /S .bld & cmake -B .bld -A Win32 -D"bz2=cef_binary_90.6.7+g19ba721+chromium-90.0.4430.212_windows32"    -D"CMAKE_INSTALL_PREFIX=G:/Prokas2/src/Extern/CEF/090.6.7"  && cmake --build .bld --target install --config Release
#rd /Q /S .bld & cmake -B .bld -A Win32 -D"bz2=cef_binary_109.1.18+gf1c41e4+chromium-109.0.5414.120_windows32" -D"CMAKE_INSTALL_PREFIX=G:/Prokas2/src/Extern/CEF/109.1.18" && cmake --build .bld --target install --config Release
#rd /Q /S .bld & cmake -B .bld -A Win32 -D"bz2=cef_binary_119.4.2+g2d7731b+chromium-119.0.6045.124_windows32"  -D"CMAKE_INSTALL_PREFIX=G:/Prokas2/src/Extern/CEF/119.4.2"  && cmake --build .bld --target install --config Release
#rd /Q /S .bld & cmake -B .bld -A Win32 -D"bz2=cef_binary_120.1.10+g3ce3184+chromium-120.0.6099.129_windows32" -D"CMAKE_INSTALL_PREFIX=G:/Prokas2/src/Extern/CEF/120.1.10" && cmake --build .bld --target install --config Release
#- debug build: remove "--config Release" or replace it with "--config Debug"
#- build existing "src": omit "-Dbz2=..."

cmake_minimum_required(VERSION 3.28)

cmake_path(GET CMAKE_CURRENT_SOURCE_DIR FILENAME PROJECT_NAME)
string(REPLACE " " "_" PROJECT_NAME ${PROJECT_NAME})
project(${PROJECT_NAME})

################################################################
function(printHelp)
    message(FATAL_ERROR [========[
********************************************************
ERROR !!! NO bz2 specified and no src folder exists! !!!
********************************************************
You can download a CEF binary package, e.g.
    cef_binary_90.6.7+g19ba721+chromium-90.0.4430.212_windows32.tar.bz2
    ...
    cef_binary_120.1.10+g3ce3184+chromium-120.0.6099.129_windows32.tar.bz2
from https://github.com/chromiumembedded/cef ... https://cef-builds.spotifycdn.com/index.html#windows32:90
then execute the following command line:
    rd /Q /S .bld & cmake -B .bld -A Win32 -D"bz2=..." -D"CMAKE_INSTALL_PREFIX=..."  && cmake --build .bld --target install --config Release
with the following parameters:
        bz2                     : CEF binary package name (without extension), e.g. cef_binary_90.6.7+g19ba721+chromium-90.0.4430.212_windows32
        CMAKE_INSTALL_PREFIX    : destination path; usually G:/Prokas2/src/Extern/CEF/090.6.7; default=dst
    ]========])
endfunction()

################################################################
function(unpackAndPatch)
    if(IS_DIRECTORY "src")
        message("rmdir src")
        file(REMOVE_RECURSE "src")
    endif()
    execute_process(
        COMMAND 7z.exe x -so "${bz2}.tar.bz2"
        COMMAND 7z.exe x -si -ttar
        COMMAND_ECHO STDOUT
        COMMAND_ERROR_IS_FATAL ANY
    )
    message("rename ${bz2} ---> src")
    file(RENAME "${bz2}" "src")
    message("rmdir src/tests")
    file(REMOVE_RECURSE "src/tests")
    execute_process(
        COMMAND git apply --ignore-space-change --ignore-whitespace MT2MD.diff
        COMMAND_ECHO STDOUT
        COMMAND_ERROR_IS_FATAL ANY
    )
endfunction()

################################################################
function(configInstall)
    set(DstLibDir "${CMAKE_INSTALL_PREFIX}/lib")
    set(DstIncDir "${CMAKE_INSTALL_PREFIX}/include")

    install(TARGETS libcef_dll_wrapper #CONFIGURATIONS Release
        #ARCHIVE         DESTINATION "${DstRlsDir}"
        LIBRARY         DESTINATION "${DstLibDir}"
        #RUNTIME         DESTINATION "${DstRlsDir}"
        PUBLIC_HEADER   DESTINATION "${DstIncDir}"
    )

    #install(DIRECTORY "src/Debug/"   DESTINATION "${DstDbgDir}" CONFIGURATIONS Debug)
    #install(DIRECTORY "src/Release/" DESTINATION "${DstRlsDir}" CONFIGURATIONS Release)
    install(DIRECTORY "src/include/" DESTINATION "${DstIncDir}")

    install(FILES "src/Release/libcef.lib "  DESTINATION "${DstLibDir}")
    install(FILES "CMakeLists.txt_dst.cmake" DESTINATION "${CMAKE_INSTALL_PREFIX}" RENAME "CMakeLists.txt")
endfunction()

################################################################
if(NOT bz2)
    if(NOT IS_DIRECTORY "src")
        printHelp()
    endif()
else()
    unpackAndPatch()
endif()

if(CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)
    set(CMAKE_INSTALL_PREFIX "${CMAKE_CURRENT_SOURCE_DIR}/dst")
    #set(CMAKE_INSTALL_PREFIX "G:/Prokas2/src/Extern/CEF/090.6.7")
endif()

add_subdirectory("src") #original (patched) files + original CMake project

configInstall()